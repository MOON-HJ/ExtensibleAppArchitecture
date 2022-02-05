//
//  TopupInteractor.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/12/04.
//

import ModernRIBs
import FinanceEntity
import FinanceRepository
import AddPaymentMethod
import CombineUtil
import RIBsUtil
import SuperUI

protocol TopupRouting: Routing {
  func cleanupViews()
  
  func attachAddPaymentMethod(closeButtonType: DismissButtonType)
  func detachAddPaymentMethod()
  func attachEnterAmount()
  func detachEnterAmount()
  func attachCardOnFile(paymentMethods: [PaymentMethod])
  func detachCardOnFile()
  func popToRoot()
}

protocol TopupListener: AnyObject {
  func topupDidClose()
  func topupDidFinish()
}

protocol TopupInteractorDependency {
  var cardOnFileRepository: CardOnFileRepositoryType { get }
  var paymentMethodStream: CurrentValuePublisher<PaymentMethod> { get }
}

final class TopupInteractor: Interactor, TopupInteractable, AddPaymentMethodListener, AdaptivePresentationControllerDelegate {
  
  weak var router: TopupRouting?
  weak var listener: TopupListener?
  private let dependency: TopupInteractorDependency
  
  let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy
  
  private var isEnterAmountRoot: Bool = false
  
  private var paymentMethods: [PaymentMethod] {
    dependency.cardOnFileRepository.cardOnFile.value
  }

  init(dependency: TopupInteractorDependency) {
    self.presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
    self.dependency = dependency
    super.init()
    self.presentationDelegateProxy.delegate = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    self.showAddCardViewOrChargingView()
  }
  
  override func willResignActive() {
    super.willResignActive()
    
    router?.cleanupViews()
    
  }
  
  func presentationControllerDidDismiss() {
    listener?.topupDidClose()
  }
  
  func addPaymentMethodDidTapClose() {
    router?.detachAddPaymentMethod()
    if !isEnterAmountRoot {
      listener?.topupDidClose()
    }
    listener?.topupDidClose()
  }
  
  func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod) {
    dependency.paymentMethodStream.send(paymentMethod)
    
    if self.isEnterAmountRoot {
      router?.popToRoot()
    } else {
      self.isEnterAmountRoot = true
      router?.attachEnterAmount()
    }
  }
  
  func enterAmountDidTapClose() {
    router?.detachEnterAmount()
    listener?.topupDidClose()
  }
  
  func enterAmountDidTapPaymentMethod() {
    router?.attachCardOnFile(paymentMethods: self.paymentMethods)
  }
  
  func enterAmountDidFinishTopup() {
    listener?.topupDidFinish()
  }
  
  func cardOnFileDidTapClose() {
    router?.detachCardOnFile()
  }
  
  func cardOnFileDidTapAddCard() {
    router?.attachAddPaymentMethod(closeButtonType: .back)
  }
  
  func didSelect(at index: Int) {
    guard let selected = paymentMethods[safe: index] else { return }
    dependency.paymentMethodStream.send(selected)
    router?.detachCardOnFile()
  }
}

// MARK: - Interact Method
extension TopupInteractor {
  private var firstCard: PaymentMethod? {
    return dependency.cardOnFileRepository.cardOnFile.value.first
  }
  
  private func showAddCardViewOrChargingView() {
    guard let firstCard = self.firstCard else {
      self.isEnterAmountRoot = false
      router?.attachAddPaymentMethod(closeButtonType: .close)
      return
    }
    
    self.isEnterAmountRoot = true
    dependency.paymentMethodStream.send(firstCard)
    
    router?.attachEnterAmount()
  }
}

//
//  TopupInteractor.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/12/04.
//

import ModernRIBs

protocol TopupRouting: Routing {
  func cleanupViews()
  
  func attachAddPaymentMethod()
  func detachAddPaymentMethod()
  func attachEnterAmount()
  func detachEnterAmount()
}

protocol TopupListener: AnyObject {
  func topupDidClose()
}

protocol TopupInteractorDependency {
  var cardOnFileRepository: CardOnFileRepositoryType { get }
}

final class TopupInteractor: Interactor, TopupInteractable, AddPaymentMethodListener, AdaptivePresentationControllerDelegate {
  
  weak var router: TopupRouting?
  weak var listener: TopupListener?
  private let dependency: TopupInteractorDependency
  
  let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy

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
    listener?.topupDidClose()
  }
  
  func addPaymentMethodDidAddCard(paymenyMethod: PaymentMethod) {
    
  }
}

// MARK: - Interact Method
extension TopupInteractor {
  private var hasCard: Bool {
    return !dependency.cardOnFileRepository.cardOnFile.value.isEmpty
  }
  
  private func showAddCardViewOrChargingView() {
    guard self.hasCard else {
      router?.attachAddPaymentMethod()
      return
    }
    
    print("❤️ 혜진아 사랑해~")
  }
}

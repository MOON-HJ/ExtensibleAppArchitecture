//
//  CardOnFileInteractor.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/12/11.
//

import ModernRIBs
import FinanceEntity

protocol CardOnFileRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFilePresentable: Presentable {
  var listener: CardOnFilePresentableListener? { get set }
  
  func update(with viewModels: [PaymentMethodViewModel])
}

protocol CardOnFileListener: AnyObject {
  func cardOnFileDidTapClose()
  func cardOnFileDidTapAddCard()
  func didSelect(at index: Int)
}

final class CardOnFileInteractor: PresentableInteractor<CardOnFilePresentable>, CardOnFileInteractable, CardOnFilePresentableListener {
  
  weak var router: CardOnFileRouting?
  weak var listener: CardOnFileListener?
  private let paymentMethods: [PaymentMethod]
  
  init(presenter: CardOnFilePresentable, paymentMethods: [PaymentMethod]) {
    self.paymentMethods = paymentMethods
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    
    presenter.update(with: self.paymentMethods.map(PaymentMethodViewModel.init))
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  func didTapClose() {
    listener?.cardOnFileDidTapClose()
  }
  
  func didSelectItem(at index: Int) {
    guard index < paymentMethods.count else {
      listener?.didSelect(at: index)
      return
    }
  
    listener?.cardOnFileDidTapAddCard()
  }
}

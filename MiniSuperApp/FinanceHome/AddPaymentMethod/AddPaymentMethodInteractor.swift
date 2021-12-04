//
//  AddPaymentMethodInteractor.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/11/21.
//

import ModernRIBs
import Combine

protocol AddPaymentMethodRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AddPaymentMethodPresentable: Presentable {
  var listener: AddPaymentMethodPresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol AddPaymentMethodListener: AnyObject {
  func addPaymentMethodDidTapClose()
  func addPaymentMethodDidAddCard(paymenyMethod: PaymentMethod)
}

protocol AddPaymentMethodInteractorDependency {
  var cardOnFileRepository: CardOnFileRepositoryType { get }
}

final class AddPaymentMethodInteractor: PresentableInteractor<AddPaymentMethodPresentable>, AddPaymentMethodInteractable, AddPaymentMethodPresentableListener {
  
  weak var router: AddPaymentMethodRouting?
  weak var listener: AddPaymentMethodListener?
  private let dependency: AddPaymentMethodInteractorDependency
  private var cancellables: Set<AnyCancellable>
  
  init(presenter: AddPaymentMethodPresentable,
       dependency: AddPaymentMethodInteractorDependency) {
    self.dependency = dependency
    self.cancellables = .init()
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    // TODO: Implement business logic here.
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  func didTapClose() {
    listener?.addPaymentMethodDidTapClose()
  }
  
  func didTapConfirm(with number: String, cvc: String, expiry: String) {
    let info = AddPaymentInfo(number: number, cvc: cvc, expiry: expiry)
    dependency.cardOnFileRepository.addCard(info: info).sink(
      receiveCompletion: { _ in },
      receiveValue: { [weak self] in
        self?.listener?.addPaymentMethodDidAddCard(paymenyMethod: $0)
      }).store(in: &cancellables)
  }
}

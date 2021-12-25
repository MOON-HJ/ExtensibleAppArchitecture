import ModernRIBs

protocol FinanceHomeRouting: ViewableRouting {
  func attachSuperPayDashBoard()
  func attachCardOnFileDashboard()
  func attachAddPaymentMethod()
  func detachAddPaymentMethod()
  func attachTopup()
  func detachTopup()
}

protocol FinanceHomePresentable: Presentable {
  var listener: FinanceHomePresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol FinanceHomeListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FinanceHomeInteractor: PresentableInteractor<FinanceHomePresentable>, FinanceHomeInteractable, FinanceHomePresentableListener, TopupListener, AdaptivePresentationControllerDelegate {
  
  weak var router: FinanceHomeRouting?
  weak var listener: FinanceHomeListener?
  
  let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init(presenter: FinanceHomePresentable) {
    self.presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
    super.init(presenter: presenter)
    presenter.listener = self
    self.presentationDelegateProxy.delegate = self
  }
  
  func presentationControllerDidDismiss() {
    router?.detachAddPaymentMethod()
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    // TODO: Implement business logic here.
    router?.attachSuperPayDashBoard()
    router?.attachCardOnFileDashboard()
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  // MARK: CardOnFileDashboardListener
  func cardOnFileDashboardDidTapAddPaymentMethod() {
    router?.attachAddPaymentMethod()
  }
  
  // MARK: AddPaymentMethodListener
  func addPaymentMethodDidTapClose() {
    router?.detachAddPaymentMethod()
  }
  
  func addPaymentMethodDidAddCard(paymenyMethod: PaymentMethod) {
    router?.detachAddPaymentMethod()
  }
  
  // MARK: SuperPayDashboardListener
  func superPayDashboardDidTapToupup() {
    router?.attachTopup()
  }
  
  // MARK: TopupListener
  func topupDidClose() {
    router?.detachTopup()
  }
  
  func topupDidFinish() {
    router?.detachTopup()
  }
}

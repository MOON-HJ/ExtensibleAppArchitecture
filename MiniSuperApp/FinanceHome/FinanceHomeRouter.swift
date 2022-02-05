import ModernRIBs
import SuperUI
import AddPaymentMethod

protocol FinanceHomeInteractable: Interactable, SuperPayDashBoardListener, CardOnFileDashboardListener, AddPaymentMethodListener, TopupListener {
  var router: FinanceHomeRouting? { get set }
  var listener: FinanceHomeListener? { get set }
  
  var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy { get }
}

protocol  FinanceHomeViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
  func addDashBoard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
  private let superPayDashboardBuildable: SuperPayDashBoardBuildable
  private var superPayRouting: Routing?
  
  private let cardOnFileDashboardBuildable: CardOnFileDashboardBuildable
  private var cardOnFileRouting: Routing?
  
  private let addPaymentMethodBuildable: AddPaymentMethodBuildable
  private var addPaymentMethodRouting: Routing?
  
  private let topupBuildable: TopupBuildable
  private var topupRouting: Routing?
  
  // TODO: Constructor inject child builder protocols to allow building children.
  init(
    interactor: FinanceHomeInteractable,
    viewController: FinanceHomeViewControllable,
    superPayDashboardBuildable: SuperPayDashBoardBuildable,
    cardOnFileBuildable: CardOnFileDashboardBuildable,
    addPaymentMethodBuildable: AddPaymentMethodBuildable,
    topupBuildable: TopupBuildable
  ) {
    self.superPayDashboardBuildable = superPayDashboardBuildable
    self.cardOnFileDashboardBuildable = cardOnFileBuildable
    self.addPaymentMethodBuildable = addPaymentMethodBuildable
    self.topupBuildable = topupBuildable
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  func attachSuperPayDashBoard() {
    guard self.superPayRouting == nil else { return }
    
    let router = superPayDashboardBuildable.build(withListener: interactor)
    
    let dashboard = router.viewControllable
    viewController.addDashBoard(dashboard)
    
    self.superPayRouting = router
    attachChild(router)
  }
  
  func attachCardOnFileDashboard() {
    guard self.cardOnFileRouting == nil else { return }
    
    let router = cardOnFileDashboardBuildable.build(withListener: interactor)
    
    let dashboard = router.viewControllable
    viewController.addDashBoard(dashboard)

    self.cardOnFileRouting = router
    attachChild(router)
  }
  
  func attachAddPaymentMethod() {
    guard addPaymentMethodRouting == nil else { return }
    
    let router = addPaymentMethodBuildable.build(withListener: interactor, closeButtonType: .close)
    let navigation  = NavigationControllerable(root: router.viewControllable)
    navigation.navigationController.presentationController?.delegate = interactor.presentationDelegateProxy
    self.viewControllable.present(navigation, animated: true, completion: nil)
    
    addPaymentMethodRouting = router
    attachChild(router)
  }
  
  func detachAddPaymentMethod() {
    guard let router = addPaymentMethodRouting else { return }
    viewControllable.dismiss(completion: nil)
    detachChild(router)
    addPaymentMethodRouting = nil
  }
  
  func attachTopup() {
    guard topupRouting == nil else { return }
    
    let router = topupBuildable.build(withListener: interactor)
    topupRouting = router
    attachChild(router)
  }
  
  func detachTopup() {
    guard let router = topupRouting else { return }
    detachChild(router)
    self.topupRouting = nil
  }
}

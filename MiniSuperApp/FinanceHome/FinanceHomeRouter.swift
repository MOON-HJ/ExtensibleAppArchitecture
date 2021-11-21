import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashBoardListener, CardOnFileDashboardListener {
  var router: FinanceHomeRouting? { get set }
  var listener: FinanceHomeListener? { get set }
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
  
  private let addPaymentBuildable: AddPaymentMethodBuildable
  private var addPaymentRouting: Routing?
  
  // TODO: Constructor inject child builder protocols to allow building children.
  init(
    interactor: FinanceHomeInteractable,
    viewController: FinanceHomeViewControllable,
    superPayDashboardBuildable: SuperPayDashBoardBuildable,
    cardOnFileBuildable: CardOnFileDashboardBuildable,
    addPaymentMethodBuildable: AddPaymentMethodBuildable
  ) {
    self.superPayDashboardBuildable = superPayDashboardBuildable
    self.cardOnFileDashboardBuildable = cardOnFileBuildable
    self.addPaymentBuildable = addPaymentMethodBuildable
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
    
  }
  
  func detachAddPaymentMethod() {
    
  }
}

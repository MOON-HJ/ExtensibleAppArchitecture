import ModernRIBs

protocol FinanceHomeDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashBoardDependency, CardOnFileDashboardDependency, AddPaymentMethodDependency, TopupDependency {
  let cardOnFileRepository: CardOnFileRepositoryType
  let superPayRepository: SuperPayRepository
  var balance: ReadOnlyCurrentValuePublisher<Double> { superPayRepository.balance }
  var topupBaseViewController: ViewControllable
  
  init(
    dependency: FinanceHomeDependency,
    cardOnFileRepository: CardOnFileRepositoryType,
    superPayRepostiory: SuperPayRepository,
    topupBaseViewController: ViewControllable) {
      self.cardOnFileRepository = cardOnFileRepository
      self.superPayRepository = superPayRepostiory
      self.topupBaseViewController = topupBaseViewController
      super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol FinanceHomeBuildable: Buildable {
  func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting
}

final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {
  
  override init(dependency: FinanceHomeDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting {
    let viewController = FinanceHomeViewController()
    let component = FinanceHomeComponent(dependency: dependency,
                                         cardOnFileRepository: CardOnFileRepository(),
                                         superPayRepostiory: BaseSuperPayRepository(),
                                         topupBaseViewController: viewController)
    let interactor = FinanceHomeInteractor(presenter: viewController)
    interactor.listener = listener
    
    let superPayDashboardBuilder = SuperPayDashBoardBuilder(dependency: component)
    let cardOnFileDashboardBuilder = CardOnFileDashboardBuilder(dependency: component)
    let addPaymentMethodBuilder = AddPaymentMethodBuilder(dependency: component)
    let topupBuilder = TopupBuilder(dependency: component)
    
    return FinanceHomeRouter(
      interactor: interactor,
      viewController: viewController,
      superPayDashboardBuildable: superPayDashboardBuilder,
      cardOnFileBuildable: cardOnFileDashboardBuilder,
      addPaymentMethodBuildable: addPaymentMethodBuilder,
      topupBuildable: topupBuilder)
  }
}

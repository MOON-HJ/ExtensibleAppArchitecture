import ModernRIBs

protocol FinanceHomeDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashBoardDependency, CardOnFileDashboardDependency, AddPaymentMethodDependency, TopupDependency {
  var cardOnFileRepository: CardOnFileRepositoryType
  var balance: ReadOnlyCurrentValuePublisher<Double> { balancePublisher }
  var topupBaseViewController: ViewControllable
  private let balancePublisher: CurrentValuePublisher<Double>
  
  init(
    dependency: FinanceHomeDependency,
    balance: CurrentValuePublisher<Double>,
    cardOnFileRepository: CardOnFileRepositoryType,
    topupBaseViewController: ViewControllable) {
      self.balancePublisher = balance
      self.cardOnFileRepository = cardOnFileRepository
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
    let balancePublisher = CurrentValuePublisher<Double>(100000)
    let viewController = FinanceHomeViewController()
    let component = FinanceHomeComponent(dependency: dependency,
                                         balance: balancePublisher,
                                         cardOnFileRepository: CardOnFileRepository(),
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

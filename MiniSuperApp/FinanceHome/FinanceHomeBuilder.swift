import ModernRIBs
import FinanceRepository
import CombineUtil
import AddPaymentMethod

protocol FinanceHomeDependency: Dependency {
  var cardOnFileRepository: CardOnFileRepositoryType { get }
  var superPayRepository: SuperPayRepository { get }
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashBoardDependency, CardOnFileDashboardDependency, AddPaymentMethodDependency, TopupDependency {
  var cardOnFileRepository: CardOnFileRepositoryType { dependency.cardOnFileRepository }
  var superPayRepository: SuperPayRepository { dependency.superPayRepository }
  var balance: ReadOnlyCurrentValuePublisher<Double> { superPayRepository.balance }
  var topupBaseViewController: ViewControllable
  
  init(
    dependency: FinanceHomeDependency,
    topupBaseViewController: ViewControllable) {
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

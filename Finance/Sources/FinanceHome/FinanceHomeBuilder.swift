import ModernRIBs
import FinanceRepository
import CombineUtil
import Topup
import AddPaymentMethod

public protocol FinanceHomeDependency: Dependency {
  var cardOnFileRepository: CardOnFileRepositoryType { get }
  var superPayRepository: SuperPayRepository { get }
  var topupBuildable: TopupBuildable { get }
  var addPaymentMethodBuildable: AddPaymentMethodBuildable { get }
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashBoardDependency, CardOnFileDashboardDependency {
  var cardOnFileRepository: CardOnFileRepositoryType { dependency.cardOnFileRepository }
  var superPayRepository: SuperPayRepository { dependency.superPayRepository }
  var balance: ReadOnlyCurrentValuePublisher<Double> { superPayRepository.balance }
  var topupBuildable: TopupBuildable { dependency.topupBuildable }
  var addPaymentMethodBuildable: AddPaymentMethodBuildable { dependency.addPaymentMethodBuildable }
}

// MARK: - Builder

public protocol FinanceHomeBuildable: Buildable {
  func build(withListener listener: FinanceHomeListener) -> ViewableRouting
}

public final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {
  
  public override init(dependency: FinanceHomeDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: FinanceHomeListener) -> ViewableRouting {
    let viewController = FinanceHomeViewController()
    let component = FinanceHomeComponent(dependency: dependency)
    let interactor = FinanceHomeInteractor(presenter: viewController)
    interactor.listener = listener
    
    let superPayDashboardBuilder = SuperPayDashBoardBuilder(dependency: component)
    let cardOnFileDashboardBuilder = CardOnFileDashboardBuilder(dependency: component)
    
    return FinanceHomeRouter(
      interactor: interactor,
      viewController: viewController,
      superPayDashboardBuildable: superPayDashboardBuilder,
      cardOnFileBuildable: cardOnFileDashboardBuilder,
      addPaymentMethodBuildable: component.addPaymentMethodBuildable,
      topupBuildable: component.topupBuildable)
  }
}

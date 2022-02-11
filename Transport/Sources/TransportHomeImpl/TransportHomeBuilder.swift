import ModernRIBs
import FinanceRepository
import CombineUtil
import TransportHome
import Topup

public protocol TransportHomeDependency: Dependency {
  var cardOnFileRepository: CardOnFileRepositoryType { get }
  var superPayRepository: SuperPayRepository { get }
  var topupBuildable: TopupBuildable { get }
}

final class TransportHomeComponent: Component<TransportHomeDependency>, TransportHomeInteractorDependency {
  let topupBaseViewController: ViewControllable
  var cardOnFileRepository: CardOnFileRepositoryType { dependency.cardOnFileRepository }
  var superPayRepository: SuperPayRepository { dependency.superPayRepository }
  var superPayBalance: ReadOnlyCurrentValuePublisher<Double> { superPayRepository.balance }
  var topupBuildable: TopupBuildable { dependency.topupBuildable}
  
  init(
    dependency: TransportHomeDependency,
    topupBaseViewController: ViewControllable
  ) {
    self.topupBaseViewController = topupBaseViewController
    super.init(dependency: dependency)
  }
}

// MARK: - Builder

public final class TransportHomeBuilder: Builder<TransportHomeDependency>, TransportHomeBuildable {
  
  public override init(dependency: TransportHomeDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: TransportHomeListener) -> ViewableRouting {
    let viewController = TransportHomeViewController()
    let component = TransportHomeComponent(dependency: dependency, topupBaseViewController: viewController)
    let interactor = TransportHomeInteractor(presenter: viewController, dependency: component)
    interactor.listener = listener
        
    return TransportHomeRouter(
      interactor: interactor,
      topupBuildable: component.topupBuildable,
      viewController: viewController
    )
  }
}

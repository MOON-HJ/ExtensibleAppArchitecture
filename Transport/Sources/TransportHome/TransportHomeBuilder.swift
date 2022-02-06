import ModernRIBs
import FinanceRepository
import CombineUtil
import Topup

public protocol TransportHomeDependency: Dependency {
  var cardOnFileRepository: CardOnFileRepositoryType { get }
  var superPayRepository: SuperPayRepository { get }
}

final class TransportHomeComponent: Component<TransportHomeDependency>, TransportHomeInteractorDependency, TopupDependency{
  let topupBaseViewController: ViewControllable
  var cardOnFileRepository: CardOnFileRepositoryType { dependency.cardOnFileRepository }
  var superPayRepository: SuperPayRepository { dependency.superPayRepository }
  var superPayBalance: ReadOnlyCurrentValuePublisher<Double> { superPayRepository.balance }
  
  init(
    dependency: TransportHomeDependency,
    topupBaseViewController: ViewControllable
  ) {
    self.topupBaseViewController = topupBaseViewController
    super.init(dependency: dependency)
  }
}

// MARK: - Builder

public protocol TransportHomeBuildable: Buildable {
  func build(withListener listener: TransportHomeListener) -> ViewableRouting
}

public final class TransportHomeBuilder: Builder<TransportHomeDependency>, TransportHomeBuildable {
  
  public override init(dependency: TransportHomeDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: TransportHomeListener) -> ViewableRouting {
    let viewController = TransportHomeViewController()
    let component = TransportHomeComponent(dependency: dependency, topupBaseViewController: viewController)
    let interactor = TransportHomeInteractor(presenter: viewController, dependency: component)
    interactor.listener = listener
    
    let topupBuilder = TopupBuilder(dependency: component)
    
    return TransportHomeRouter(
      interactor: interactor,
      topupBuildable: topupBuilder,
      viewController: viewController
    )
  }
}

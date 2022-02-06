import ModernRIBs
import FinanceRepository
import CombineUtil
import Topup

protocol TransportHomeDependency: Dependency {
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

protocol TransportHomeBuildable: Buildable {
  func build(withListener listener: TransportHomeListener) -> TransportHomeRouting
}

final class TransportHomeBuilder: Builder<TransportHomeDependency>, TransportHomeBuildable {
  
  override init(dependency: TransportHomeDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: TransportHomeListener) -> TransportHomeRouting {
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

import ModernRIBs
import FinanceRepository
import TransportHome

public protocol AppHomeDependency: Dependency {
  var cardOnFileRepository: CardOnFileRepositoryType { get }
  var superPayRepository: SuperPayRepository { get }
}

final class AppHomeComponent: Component<AppHomeDependency>, TransportHomeDependency {
  var cardOnFileRepository: CardOnFileRepositoryType { dependency.cardOnFileRepository }
  var superPayRepository: SuperPayRepository { dependency.superPayRepository }
}

// MARK: - Builder

public protocol AppHomeBuildable: Buildable {
  func build(withListener listener: AppHomeListener) -> ViewableRouting
}

public final class AppHomeBuilder: Builder<AppHomeDependency>, AppHomeBuildable {
  
  public override init(dependency: AppHomeDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: AppHomeListener) -> ViewableRouting {
    let component = AppHomeComponent(dependency: dependency)
    let viewController = AppHomeViewController()
    let interactor = AppHomeInteractor(presenter: viewController)
    interactor.listener = listener
    
    let transportHomeBuilder = TransportHomeBuilder(dependency: component)
    
    return AppHomeRouter(
      interactor: interactor,
      viewController: viewController,
      transportHomeBuildable: transportHomeBuilder
    )
  }
}

//
//  TopupBuilder.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/12/04.
//

import ModernRIBs

protocol TopupDependency: Dependency {
  var topupBaseViewController: ViewControllable { get }
  var cardOnFileRepository: CardOnFileRepositoryType { get }
}

final class TopupComponent: Component<TopupDependency>, TopupInteractorDependency, AddPaymentMethodDependency {
  var cardOnFileRepository: CardOnFileRepositoryType { dependency.cardOnFileRepository }
  fileprivate var topupBaseViewController: ViewControllable { dependency.topupBaseViewController }
  
  
  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol TopupBuildable: Buildable {
  func build(withListener listener: TopupListener) -> TopupRouting
}

final class TopupBuilder: Builder<TopupDependency>, TopupBuildable {
  
  override init(dependency: TopupDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: TopupListener) -> TopupRouting {
    let component = TopupComponent(dependency: dependency)
    let interactor = TopupInteractor(dependency: component)
    let addPaymentMethodBuilder = AddPaymentMethodBuilder(dependency: component)
    interactor.listener = listener
    return TopupRouter(
      interactor: interactor,
      viewController: component.topupBaseViewController,
      addPaymentMethodBuildable: addPaymentMethodBuilder)
  }
}

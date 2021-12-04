//
//  CardOnFileDashboardBuilder.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/11/14.
//

import ModernRIBs

protocol CardOnFileDashboardDependency: Dependency {
  var cardOnFileRepository: CardOnFileRepositoryType { get}
}

final class CardOnFileDashboardComponent: Component<CardOnFileDashboardDependency>, CardOnFileDashboardInteractorDependency {
  var cardsOnFileRepository: CardOnFileRepositoryType { dependency.cardOnFileRepository }
  
}

// MARK: - Builder

protocol CardOnFileDashboardBuildable: Buildable {
  func build(withListener listener: CardOnFileDashboardListener) -> CardOnFileDashboardRouting
}

final class CardOnFileDashboardBuilder: Builder<CardOnFileDashboardDependency>, CardOnFileDashboardBuildable {
  
  override init(dependency: CardOnFileDashboardDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: CardOnFileDashboardListener) -> CardOnFileDashboardRouting {
    let component = CardOnFileDashboardComponent(dependency: dependency)
    let viewController = CardOnFileDashboardViewController()
    let interactor = CardOnFileDashboardInteractor(
      presenter: viewController,
      dependency: component )
    interactor.listener = listener
    return CardOnFileDashboardRouter(interactor: interactor, viewController: viewController)
  }
}

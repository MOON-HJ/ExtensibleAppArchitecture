//
//  SuperPayDashBoardBuilder.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/10/31.
//

import ModernRIBs
import Foundation
import CombineUtil

protocol SuperPayDashBoardDependency: Dependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }

}

final class SuperPayDashBoardComponent: Component<SuperPayDashBoardDependency>, SuperPayDashboardInteractorDependency {
  var balance: ReadOnlyCurrentValuePublisher<Double> { dependency.balance }
  var balanceFormatter: NumberFormatter { Formatter.balanceFormatter }
  

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SuperPayDashBoardBuildable: Buildable {
    func build(withListener listener: SuperPayDashBoardListener) -> SuperPayDashBoardRouting
}

final class SuperPayDashBoardBuilder: Builder<SuperPayDashBoardDependency>, SuperPayDashBoardBuildable {

    override init(dependency: SuperPayDashBoardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SuperPayDashBoardListener) -> SuperPayDashBoardRouting {
        let component = SuperPayDashBoardComponent(dependency: dependency)
        let viewController = SuperPayDashBoardViewController()
        let interactor = SuperPayDashBoardInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return SuperPayDashBoardRouter(interactor: interactor, viewController: viewController)
    }
}

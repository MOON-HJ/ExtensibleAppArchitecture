//
//  SuperPayDashBoardInteractor.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/10/31.
//

import ModernRIBs
import Combine
import Foundation

protocol SuperPayDashBoardRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SuperPayDashBoardPresentable: Presentable {
  var listener: SuperPayDashBoardPresentableListener? { get set }
  
  func updateBalance(_ balance: String)
}

protocol SuperPayDashBoardListener: AnyObject {
  func superPayDashboardDidTapToupup()
}

protocol SuperPayDashboardInteractorDependency {
  var balance: ReadOnlyCurrentValuePublisher<Double> { get }
  var balanceFormatter: NumberFormatter { get }
}

final class SuperPayDashBoardInteractor: PresentableInteractor<SuperPayDashBoardPresentable>, SuperPayDashBoardInteractable, SuperPayDashBoardPresentableListener {
  
  weak var router: SuperPayDashBoardRouting?
  weak var listener: SuperPayDashBoardListener?
  
  private let dependency: SuperPayDashboardInteractorDependency
  private var cancellables: Set<AnyCancellable>
  
  init(
    presenter: SuperPayDashBoardPresentable,
    dependency: SuperPayDashboardInteractorDependency
  ) {
    self.dependency = dependency
    self.cancellables = .init()
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    
    dependency.balance
      .receive(on: DispatchQueue.main)
      .sink { [weak self] in
      self?.dependency.balanceFormatter.string(from: NSNumber(value: $0))
        .map { self?.presenter.updateBalance($0) }
    }.store(in: &cancellables )
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  func topupButtonDidTap() {
    listener?.superPayDashboardDidTapToupup()
  }
}

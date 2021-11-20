//
//  CardOnFileDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/11/14.
//

import ModernRIBs
import Combine

protocol CardOnFileDashboardRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFileDashboardPresentable: Presentable {
  var listener: CardOnFileDashboardPresentableListener? { get set }
  
  func update(with models: [PaymentMethodViewModel])
}

protocol CardOnFileDashboardListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol CardOnFileDashboardInteractorDependency {
  var cardsOnFileRepository: CardOnFileRepositoryType { get }
}

final class CardOnFileDashboardInteractor: PresentableInteractor<CardOnFileDashboardPresentable>, CardOnFileDashboardInteractable, CardOnFileDashboardPresentableListener {
  
  weak var router: CardOnFileDashboardRouting?
  weak var listener: CardOnFileDashboardListener?
  private let dependency: CardOnFileDashboardInteractorDependency
  private var cancellables: Set<AnyCancellable>
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  init(presenter: CardOnFileDashboardPresentable,
                dependency: CardOnFileDashboardInteractorDependency) {
    self.dependency = dependency
    self.cancellables = .init()
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    
    dependency.cardsOnFileRepository.cardOnFile.sink {
      let viewModels = $0.prefix(5).map { PaymentMethodViewModel($0) }
      self.presenter.update(with: viewModels)
    }.store(in: &cancellables)
    
  }
  
  override func willResignActive() {
    super.willResignActive()
    cancellables.forEach { $0.cancel() }
    cancellables.removeAll()
  }
}

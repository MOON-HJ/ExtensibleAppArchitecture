//
//  TopupBuilder.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/12/04.
//

import ModernRIBs
import FinanceEntity
import FinanceRepository
import CombineUtil
import AddPaymentMethod

public protocol TopupDependency: Dependency {
  var topupBaseViewController: ViewControllable { get }
  var cardOnFileRepository: CardOnFileRepositoryType { get }
  var superPayRepository: SuperPayRepository { get }
}

final class TopupComponent: Component<TopupDependency>, TopupInteractorDependency, AddPaymentMethodDependency, EnterAmountDependency, CardOnFileDependency {
  
  var selectedPaymentMethods: ReadOnlyCurrentValuePublisher<PaymentMethod> { paymentMethodStream }
  var cardOnFileRepository: CardOnFileRepositoryType { dependency.cardOnFileRepository }
  var superPayRepository: SuperPayRepository { dependency.superPayRepository }

  fileprivate var topupBaseViewController: ViewControllable { dependency.topupBaseViewController }

  let paymentMethodStream: CurrentValuePublisher<PaymentMethod>
  
  init(
    dependency: TopupDependency,
    paymentMethodStream: CurrentValuePublisher<PaymentMethod>
  ) {
    self.paymentMethodStream = paymentMethodStream
    super.init(dependency: dependency)
  }
}

// MARK: - Builder

public protocol TopupBuildable: Buildable {
  func build(withListener listener: TopupListener) -> Routing
}

public final class TopupBuilder: Builder<TopupDependency>, TopupBuildable {
  
  public override init(dependency: TopupDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: TopupListener) -> Routing {
    let paymentMethodStream = CurrentValuePublisher<PaymentMethod>(.init(id: "", name: "", digits: "", color: "", isPrimary: false))
    
    let component = TopupComponent(dependency: dependency, paymentMethodStream: paymentMethodStream)
    let interactor = TopupInteractor(dependency: component)
    interactor.listener = listener
    
    let addPaymentMethodBuilder = AddPaymentMethodBuilder(dependency: component)
    let enterAmountBuilder = EnterAmountBuilder(dependency: component)
    let cardOnFileBuilder = CardOnFileBuilder(dependency: component)
    
    return TopupRouter(
      interactor: interactor,
      viewController: component.topupBaseViewController,
      addPaymentMethodBuildable: addPaymentMethodBuilder,
      enterAmountBuildable: enterAmountBuilder,
      cardOnFileBuildable: cardOnFileBuilder)
  }
}

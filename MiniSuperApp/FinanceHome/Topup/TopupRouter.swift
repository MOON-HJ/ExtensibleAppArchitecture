//
//  TopupRouter.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/12/04.
//

import ModernRIBs

protocol TopupInteractable: Interactable, AddPaymentMethodListener {
  var router: TopupRouting? { get set }
  var listener: TopupListener? { get set }
  
  var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy { get }
}

final class TopupRouter: Router<TopupInteractable>, TopupRouting {
  private var navigationControllable: NavigationControllerable?
  
  private let addPaymentMethodBuildable : AddPaymentMethodBuildable
  private var addPaymentMethodRouting: Routing?
  
  init(interactor: TopupInteractable,
       viewController: ViewControllable,
       addPaymentMethodBuildable: AddPaymentMethodBuildable) {
    self.viewController = viewController
    self.addPaymentMethodBuildable = addPaymentMethodBuildable
    super.init(interactor: interactor)
    interactor.router = self
  }
  
  func cleanupViews() {
    guard viewController.uiviewController.presentationController == nil || navigationControllable == nil
    else { return }
    
    navigationControllable?.dismiss(completion: nil)
  }
  
  func attachAddPaymentMethod() {
    guard addPaymentMethodRouting == nil else { return }

    let router = addPaymentMethodBuildable.build(withListener: interactor)
    self.presentInsideNavigation(router.viewControllable)
    
    addPaymentMethodRouting = router
    attachChild(router)
  }
  
  func detachAddPaymentMethod() {
    guard let router = addPaymentMethodRouting else { return }
    self.dismissInsideNavigation(completion: nil)
    detachChild(router)
    self.addPaymentMethodRouting = nil
  }
  
  
  // MARK: - Private
  
  private let viewController: ViewControllable
  
  private func presentInsideNavigation(_ viewControllable: ViewControllable) {
    let navigation  = NavigationControllerable(root: viewControllable)
    self.navigationControllable = navigation
    navigation.navigationController.presentationController?.delegate = interactor.presentationDelegateProxy
    viewController.present(navigation, animated: true, completion: nil)
  }
  
  private func dismissInsideNavigation(completion: (() -> Void)?) {
    guard self.navigationControllable == nil else { return }
    viewController.dismiss(completion: completion)
    self.navigationControllable = nil
  }
}

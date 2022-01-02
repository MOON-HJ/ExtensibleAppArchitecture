//
//  TopupRouter.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/12/04.
//

import ModernRIBs

protocol TopupInteractable: Interactable, AddPaymentMethodListener, EnterAmountListener, CardOnFileListener {
  var router: TopupRouting? { get set }
  var listener: TopupListener? { get set }
  
  var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy { get }
}

final class TopupRouter: Router<TopupInteractable>, TopupRouting {
  private var navigationControllable: NavigationControllerable?
  
  private let addPaymentMethodBuildable : AddPaymentMethodBuildable
  private var addPaymentMethodRouting: Routing?
  
  private let enterAmountBuildable: EnterAmountBuildable
  private var enterAmountRouting: Routing?
  
  private let cardOnFileBuildlable: CardOnFileBuildable
  private var cardOnFileRouting: Routing?
  
  init(interactor: TopupInteractable,
       viewController: ViewControllable,
       addPaymentMethodBuildable: AddPaymentMethodBuildable,
       enterAmountBuildable: EnterAmountBuildable,
       cardOnFileBuildable: CardOnFileBuildable) {
    self.viewController = viewController
    self.addPaymentMethodBuildable = addPaymentMethodBuildable
    self.enterAmountBuildable = enterAmountBuildable
    self.cardOnFileBuildlable = cardOnFileBuildable
    super.init(interactor: interactor)
    interactor.router = self
  }
  
  func cleanupViews() {
    guard viewController.uiviewController.presentedViewController != nil,
          navigationControllable != nil else { return }
    navigationControllable?.dismiss(completion: nil)
  }
  
  func attachAddPaymentMethod(closeButtonType: DismissButtonType) {
    guard addPaymentMethodRouting == nil else { return }
    
    let router = addPaymentMethodBuildable.build(withListener: interactor, closeButtonType: closeButtonType)
    
    if let navigationControllable = navigationControllable {
      navigationControllable.pushViewController(router.viewControllable, animated: true)
    } else {
      self.presentInsideNavigation(router.viewControllable)
    }
    
    attachChild(router)
    addPaymentMethodRouting = router
  }
  
  func detachAddPaymentMethod() {
    guard let router = addPaymentMethodRouting else { return }
    navigationControllable?.popViewController(animated: true)
    detachChild(router)
    self.addPaymentMethodRouting = nil
  }
  
  func attachEnterAmount() {
    guard enterAmountRouting == nil else { return }
    
    let router = enterAmountBuildable.build(withListener: interactor)
    
    if let navigation = navigationControllable {
      navigation.setViewControllers([router.viewControllable])
      self.resetChildRouting()
    } else {
      self.presentInsideNavigation(router.viewControllable)
    }
    
    attachChild(router)
    enterAmountRouting = router
  }
  
  func detachEnterAmount() {
    guard let router = enterAmountRouting else { return }
    self.dismissInsideNavigation(completion: nil)
    detachChild(router)
    self.enterAmountRouting = nil
  }
  
  func attachCardOnFile(paymentMethods: [PaymentMethod]) {
    guard cardOnFileRouting == nil else { return }
    let router = cardOnFileBuildlable.build(withListener: interactor, paymentMethods: paymentMethods)
    navigationControllable?.pushViewController(router.viewControllable, animated: true)
    cardOnFileRouting = router
    attachChild(router)
  }
  
  func detachCardOnFile() {
    guard let router = cardOnFileRouting else { return }
    navigationControllable?.popViewController(animated: true)
    detachChild(router)
    cardOnFileRouting = nil
  }
  
  func popToRoot() {
    navigationControllable?.popToRoot(animated: true)
    resetChildRouting()
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
  
  private func resetChildRouting() {
    if let cardOnFileRouting = cardOnFileRouting {
      detachChild(cardOnFileRouting)
      self.cardOnFileRouting = nil
    }
    
    if let addPaymentMethodRouting = addPaymentMethodRouting {
      detachChild(addPaymentMethodRouting)
      self.addPaymentMethodRouting = nil
    }
  }
}

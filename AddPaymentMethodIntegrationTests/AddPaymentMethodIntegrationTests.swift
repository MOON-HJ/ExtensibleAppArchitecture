//
//  AddPaymentMethodIntegrationTests.swift
//  AddPaymentMethodIntegrationTests
//
//  Created by 문효재 on 2022/03/06.
//

import XCTest
import Hammer
import FinanceRepository
import FinanceRepositoryTestSupport
import AddPaymentMethod
import AddPaymentMethodTestSupport
import ModernRIBs
@testable import AddPaymentMethodImpl

class AddPaymentMethodIntegrationTests: XCTestCase {
  private var eventGenaratror: EventGenerator!
  private var dependency: AddPaymentMethodDependencyMock!
  private var listener: AddPaymentMethodListener!
  private var viewController: UIViewController!
  private var router: Routing!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    self.dependency = AddPaymentMethodDependencyMock()
    let builder = AddPaymentMethodBuilder(dependency: self.dependency)
    self.listener = AddPaymentMethodListenerMock()
    let router = builder.build(withListener: self.listener, closeButtonType: .close)
    
    self.viewController = router.viewControllable.uiviewController
    
    eventGenaratror = try EventGenerator(viewController: self.viewController)
    
    router.load()
    router.interactable.activate()
    
    self.router = router
  }
  
  func testAddPaymentMethod() throws {
    try eventGenaratror.wait(3)
  }
}


final class AddPaymentMethodDependencyMock: AddPaymentMethodDependency {
  var cardOnFileRepository: CardOnFileRepositoryType = CardOnFileRepositoryMock()
  
}

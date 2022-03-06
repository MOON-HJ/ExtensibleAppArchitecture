//
//  AddPaymentMethodIntegrationTests.swift
//  AddPaymentMethodIntegrationTests
//
//  Created by 문효재 on 2022/03/06.
//

import XCTest
import Hammer

import FinanceEntity
import FinanceRepository
import FinanceRepositoryTestSupport
import AddPaymentMethod
import AddPaymentMethodTestSupport
import ModernRIBs
import RIBsUtil
@testable import AddPaymentMethodImpl

class AddPaymentMethodIntegrationTests: XCTestCase {
  private var eventGenaratror: EventGenerator!
  private var dependency: AddPaymentMethodDependencyMock!
  private var listener: AddPaymentMethodListenerMock!
  private var viewController: UIViewController!
  private var router: Routing!
  
  private var repository: CardOnFileRepositoryMock {
    dependency.cardOnFileRepository as! CardOnFileRepositoryMock
  }
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    self.dependency = AddPaymentMethodDependencyMock()
    let builder = AddPaymentMethodBuilder(dependency: self.dependency)
    self.listener = AddPaymentMethodListenerMock()
    let router = builder.build(withListener: self.listener, closeButtonType: .close)
    
    let navigation = NavigationControllerable(root: router.viewControllable)
    self.viewController = navigation.uiviewController
    
    eventGenaratror = try EventGenerator(viewController: navigation.navigationController)
    
    router.load()
    router.interactable.activate()
    
    self.router = router
  }
  
  func testAddPaymentMethod() throws {
    // given
    repository.addedPaymentMethod = PaymentMethod(
      id: "1234",
      name: "",
      digits: "",
      color: "",
      isPrimary: false)
    
    let cardNumberTextField = try eventGenaratror.viewWithIdentifier("addpaymentmethod_cardnumber_textfield")
    try eventGenaratror.fingerTap(at: cardNumberTextField)
    try eventGenaratror.keyType("12345678234567")

    let securityTextField = try eventGenaratror.viewWithIdentifier("addpaymentmethod_security_textfield")
    try eventGenaratror.fingerTap(at: securityTextField)
    try eventGenaratror.keyType("123")

    let expiryTextField = try eventGenaratror.viewWithIdentifier("addpaymentmethod_expiry_textfield")
    try eventGenaratror.fingerTap(at: expiryTextField)
    try eventGenaratror.keyType("1212")
    try eventGenaratror.wait(5)
    
    // when
    let confirm = try eventGenaratror.viewWithIdentifier("addpaymentmethod_addcard_button")
    try eventGenaratror.fingerTap(at: confirm)
    
    // then
    XCTAssertEqual(repository.addCardCallCount, 1)
    try eventGenaratror.wait(0.2)
    XCTAssertEqual(listener.addPaymentMethodDidAddCardCallCount, 1)
    XCTAssertEqual(listener.addPaymentMethodDidAddCardPaymentMethod?.id, "1234")
  }
}


final class AddPaymentMethodDependencyMock: AddPaymentMethodDependency {
  var cardOnFileRepository: CardOnFileRepositoryType = CardOnFileRepositoryMock()
  
}

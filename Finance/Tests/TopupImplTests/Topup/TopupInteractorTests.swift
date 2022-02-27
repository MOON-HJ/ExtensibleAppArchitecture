//
//  TopupInteractorTests.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2022/02/24.
//

@testable import TopupImpl
import XCTest
import FinanceEntity
import TopupTestSupport
import FinanceRepositoryTestSupport

final class TopupInteractorTests: XCTestCase {
  
  private var sut: TopupInteractor!
  private var dependency: TopupDependencyMock!
  private var listener: TopupListenerMock!
  private var router: TopupRoutingMock!
  
  private var cardOnFileRepository: CardOnFileRepositoryMock {
    dependency.cardOnFileRepository as! CardOnFileRepositoryMock
  }
  
  // TODO: declare other objects and mocks you need as private vars
  
  override func setUp() {
    super.setUp()
    
    self.dependency = TopupDependencyMock()
    self.listener = TopupListenerMock()
    
    let interactor = TopupInteractor(dependency: self.dependency)
    self.router = TopupRoutingMock(interactable: interactor)
    
    interactor.listener = self.listener
    interactor.router = self.router
    self.sut = interactor
  }
  
  // MARK: - Tests
  
  func testActivate() {
    // given
    let cards = [
      PaymentMethod(id: "0", name: "Zero", digits: "0123", color: "", isPrimary: false)
    ]
    
    cardOnFileRepository.cardOnFileSubject.send(cards)
    
    // when
    sut.activate()
    
    // then
    XCTAssertEqual(router.attachEnterAmountCallCount, 1)
    XCTAssertEqual(dependency.paymentMethodStream.value.name, "Zero")
  }
  
  func testActivateWithoudCard() {
    // given
    cardOnFileRepository.cardOnFileSubject.send([])
    
    // when
    sut.activate()
    
    // then
    XCTAssertEqual(router.attachAddPaymentMethodCallCount, 1)
    XCTAssertEqual(router.attachAddPaymentMethodCloseButtonType, .close)
  }
  
  
}

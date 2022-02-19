//
//  EnterAmountInteractorTests.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2022/02/18.
//

@testable import TopupImpl
import XCTest

final class EnterAmountInteractorTests: XCTestCase {
  
  private var sut: EnterAmountInteractor! // System Under Test
  private var presenter: EnterAmountPresentableMock!
  private var dependency: EnterAmountDependencyMock!
  
  override func setUp() {
    super.setUp()
    self.presenter = EnterAmountPresentableMock()
    self.dependency = EnterAmountDependencyMock()
    
    sut = EnterAmountInteractor(
      presenter: self.presenter,
      dependency: self.dependency)
    
    // TODO: instantiate objects and mocks
  }
  
  // MARK: - Tests
  
  func test_exampleObservable_callsRouterOrListener_exampleProtocol() {
    // This is an example of an interactor test case.
    // Test your interactor binds observables and sends messages to router or listener.
  }
}

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

final class TopupInteractorTests: XCTestCase {
  
  private var sut: TopupInteractor!
  private var dependency: TopupDependencyMock!
  private var listener: TopupListenerMock!
  private var router: TopupRoutingMock!
  
  
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
  
  func test_exampleObservable_callsRouterOrListener_exampleProtocol() {
    // This is an example of an interactor test case.
    // Test your interactor binds observables and sends messages to router or listener.
  }
}

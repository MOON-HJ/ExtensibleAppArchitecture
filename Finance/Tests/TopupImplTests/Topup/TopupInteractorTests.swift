//
//  TopupInteractorTests.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2022/02/24.
//

@testable import TopupImpl
import XCTest

final class TopupInteractorTests: XCTestCase {
  
  private var sut: TopupInteractor!
  private var dependency: TopupDependencyMock!
  
  // TODO: declare other objects and mocks you need as private vars
  
  override func setUp() {
    super.setUp()
    
    self.dependency = TopupDependencyMock()
    sut = TopupInteractor(dependency: dependency)
    sut.listener
    // TODO: instantiate objects and mocks
  }
  
  // MARK: - Tests
  
  func test_exampleObservable_callsRouterOrListener_exampleProtocol() {
    // This is an example of an interactor test case.
    // Test your interactor binds observables and sends messages to router or listener.
  }
}

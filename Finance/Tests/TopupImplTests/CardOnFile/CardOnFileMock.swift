//
//  CardOnFileMock.swift
//  
//
//  Created by 문효재 on 2022/02/27.
//

import Foundation
@testable import TopupImpl
import FinanceEntity
import RIBsTestSupport

final class CardOnFileBuildableMock: CardOnFileBuildable {
  var buildHandler: ((_  listener: CardOnFileListener) -> CardOnFileRouting)?
  
  var buildCallCount = 0
  var buildPaymentMethods: [PaymentMethod]?
  func build(withListener listener: CardOnFileListener, paymentMethods: [PaymentMethod]) -> CardOnFileRouting {
    buildCallCount += 1
    buildPaymentMethods = paymentMethods
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
}

final class CardOnFileRoutingMock: ViewableRoutingMock, CardOnFileRouting {
  
}

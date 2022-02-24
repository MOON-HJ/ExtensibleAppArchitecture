//
//  CardOnFileRepositoryMock.swift
//  
//
//  Created by 문효재 on 2022/02/24.
//

import Foundation
import FinanceRepository
import FinanceEntity
import CombineUtil
import Combine

public final class CardOnFileRepositoryMock: CardOnFileRepositoryType {
  public var cardOnFileSubject : CurrentValuePublisher<[PaymentMethod]> = .init([])
  public var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { cardOnFileSubject }
  
  public var addCardCallCount = 0
  public var addCardInfo: AddPaymentInfo?
  public var addedPaymentMethod: PaymentMethod?
  
  public func addCard(info: AddPaymentInfo) -> AnyPublisher<PaymentMethod, Error> {
    addCardCallCount += 1
    addCardInfo = info
    
    if let addedPaymentMethod = addedPaymentMethod {
      return Just(addedPaymentMethod).setFailureType(to: Error.self).eraseToAnyPublisher()
    } else {
      return Fail(error: NSError(domain: "CardOnFileRepositoryMock", code: 0, userInfo: nil)).eraseToAnyPublisher()
    }
  }
  
  public var fetchCallCount = 0
  public func fetch() {
    fetchCallCount += 1
  }
  
  
  public init() { }

}

//
//  File.swift
//  
//
//  Created by 문효재 on 2022/02/24.
//

import Foundation
@testable import TopupImpl
import FinanceEntity
import FinanceRepository
import FinanceRepositoryTestSupport
import CombineUtil

final class TopupDependencyMock: TopupInteractorDependency {
  var cardOnFileRepository: CardOnFileRepositoryType = CardOnFileRepositoryMock()
  var paymentMethodStream: CurrentValuePublisher<PaymentMethod> = .init(PaymentMethod(id: "", name: "", digits: "", color: "", isPrimary: false))
  
  
}

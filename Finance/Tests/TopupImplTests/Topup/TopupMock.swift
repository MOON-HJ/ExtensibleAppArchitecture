//
//  File.swift
//  
//
//  Created by 문효재 on 2022/02/24.
//

import Foundation
@testable import TopupImpl

final class TopupDependencyMock: TopupInteractorDependency {
  var cardOnFileRepository: CardOnFileRepositoryType
  
  var paymentMethodStream: CurrentValuePublisher<PaymentMethod>
  
  
}

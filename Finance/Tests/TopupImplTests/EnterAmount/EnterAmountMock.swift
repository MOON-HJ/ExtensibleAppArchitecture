//
//  EnterAmountMock.swift
//  
//
//  Created by 문효재 on 2022/02/18.
//

import Foundation
import CombineUtil
import FinanceEntity
import FinanceRepository
import FinanceRepositoryTestSupport
@testable import TopupImpl

final class EnterAmountPresentableMock: EnterAmountPresentable {
  var listener: EnterAmountPresentableListener?
  
  var updateSelectedPaymentMethodCallCount = 0
  var updateSelectedPaymentMethodViewModel: SelectedPaymentMethodViewModel?
  
  func updateSelectedPaymentMethod(with viewModel: SelectedPaymentMethodViewModel) {
    updateSelectedPaymentMethodCallCount += 1
    updateSelectedPaymentMethodViewModel = viewModel
  }
  
  var startLoadingCallCount = 0
  func startLoading() {
    startLoadingCallCount += 1
  }
  
  var stopLoadingCallCount = 0
  func stopLoading() {
    stopLoadingCallCount += 1
  }
  
  init() {
    
  }
}

final class EnterAmountDependencyMock: EnterAmountInteractorDependency {
  var selectedPaymentMethoSubject = CurrentValuePublisher<PaymentMethod>(
    PaymentMethod(id: "", name: "", digits: "", color: "", isPrimary: false)
  )
  var selectedPaymentMethods: ReadOnlyCurrentValuePublisher<PaymentMethod> { selectedPaymentMethoSubject }
  var superPayRepository: SuperPayRepository = SuperPayRepositoryMock()
}

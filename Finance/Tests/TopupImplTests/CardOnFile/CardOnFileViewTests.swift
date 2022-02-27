//
//  CardOnFileViewTests.swift
//
//
//  Created by 문효재 on 2022/02/27.
//

import XCTest
import Foundation
@testable import TopupImpl
import SnapshotTesting
import FinanceEntity

final class CardOnFileViewTests: XCTestCase {
  func testCardOnFile() {
    // given
    let viewModels = [
      PaymentMethodViewModel(PaymentMethod(id: "0", name: "우리은행", digits: "1111", color: "#51AF80FF", isPrimary: false)),
      PaymentMethodViewModel(PaymentMethod(id: "1", name: "현대카드", digits: "2222", color: "#F19A38FF", isPrimary: false)),
      PaymentMethodViewModel(PaymentMethod(id: "2", name: "신한카드", digits: "3333", color: "#78C5F5FF", isPrimary: false)),
    ]
    
    // when
    let sut = CardOnFileViewController()
    sut.update(with: viewModels)
    
    // then
    assertSnapshot(matching: sut, as: .image(on: .iPhoneXsMax))
  }
}

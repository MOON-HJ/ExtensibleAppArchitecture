//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/11/20.
//

import Foundation

protocol CardOnFileRepositoryType {
  var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
}

final class CardOnFileRepository: CardOnFileRepositoryType {
  var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }
  
  private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
    .init(id: "0", name: "우리은행", digits: "0123", color: "#F19A38FF", isPrimary: false),
    .init(id: "1", name: "신한카드", digits: "5672", color: "#3478F6FF", isPrimary: false),
    .init(id: "2", name: "현대카드", digits: "4567", color: "#78C5F5FF", isPrimary: false),
    .init(id: "3", name: "국민은행", digits: "1234", color: "#65C466FF", isPrimary: false),
    .init(id: "4", name: "카카오뱅크", digits: "6455", color: "#FFCC00FF", isPrimary: false),
  ])
}

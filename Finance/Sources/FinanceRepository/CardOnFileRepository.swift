//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/11/20.
//

import Foundation
import Combine
import FinanceEntity
import CombineUtil
import Network

public protocol CardOnFileRepositoryType {
  var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
  func addCard(info: AddPaymentInfo) -> AnyPublisher<PaymentMethod, Error>
  func fetch()
}

public final class CardOnFileRepository: CardOnFileRepositoryType {
  public var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }
  
  private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
//    .init(id: "0", name: "우리은행", digits: "0123", color: "#F19A38FF", isPrimary: false),
//    .init(id: "1", name: "신한카드", digits: "5672", color: "#3478F6FF", isPrimary: false),
//    .init(id: "2", name: "현대카드", digits: "4567", color: "#78C5F5FF", isPrimary: false),
//    .init(id: "3", name: "국민은행", digits: "1234", color: "#65C466FF", isPrimary: false),
//    .init(id: "4", name: "카카오뱅크", digits: "6455", color: "#FFCC00FF", isPrimary: false),
  ])
  
  private let network: Network
  private let baseURL: URL
  private var cancellables: Set<AnyCancellable>
  
  public init(network: Network, baseURL: URL) {
    self.network = network
    self.baseURL = baseURL
    self.cancellables = .init()
  }
  
  public func fetch() {
    let request = CardOnFileRequest(baseURL: baseURL)
    network.send(request)
      .map(\.output.cards)
      .sink(
        receiveCompletion: { _ in },
        receiveValue: { [weak self] cards in
          self?.paymentMethodsSubject.send(cards)
        })
      .store(in: &cancellables)
  }
  
  public func addCard(info: AddPaymentInfo) -> AnyPublisher<PaymentMethod, Error> {
    let request = AddCardRequest(baseURL: baseURL, info: info)
    
    return network.send(request)
      .map(\.output.card)
      .handleEvents(
        receiveSubscription: nil,
        receiveOutput: { [weak self] method in
          guard let this = self else { return }
          this.paymentMethodsSubject.send(this.paymentMethodsSubject.value + [method])
        },
        receiveCompletion: nil,
        receiveCancel: nil,
        receiveRequest: nil)
      .eraseToAnyPublisher()
  }
}

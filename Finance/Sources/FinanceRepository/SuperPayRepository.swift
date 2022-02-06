//
//  SuperPayRepository.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/12/25.
//

import Foundation
import Combine
import CombineUtil

public protocol SuperPayRepository {
  var balance: ReadOnlyCurrentValuePublisher<Double> { get }
  
  func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error>
}

public final class BaseSuperPayRepository: SuperPayRepository {
  public var balance: ReadOnlyCurrentValuePublisher<Double> { balanceSubject }
  private let balanceSubject = CurrentValuePublisher<Double>(0)
  
  public init() { }
  
  public func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error> {
    return Future<Void, Error> { [weak self] promise in
      self?.backgroundQueue.async {
        Thread.sleep(forTimeInterval: 2)
        promise(.success(()))
        let newBalance = (self?.balance.value).map { $0 + amount }
        newBalance.map { self?.balanceSubject.send($0) }
      }
    }
    .eraseToAnyPublisher()
  }
  
  private let backgroundQueue = DispatchQueue(label: "topup.repository.queue")
}
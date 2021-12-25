//
//  SuperPayRepository.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/12/25.
//

import Foundation

protocol SuperPayRepository {
  var balance: ReadOnlyCurrentValuePublisher<Double> { get }
}

final class BaseSuperPayRepository: SuperPayRepository {
  var balance: ReadOnlyCurrentValuePublisher<Double> { balanceSubject }
  private let balanceSubject = CurrentValuePublisher<Double>(0)
}

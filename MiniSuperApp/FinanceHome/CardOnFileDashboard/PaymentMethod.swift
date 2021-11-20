//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/11/20.
//

struct PaymentMethod: Decodable {
  let id: String
  let name: String
  let digits: String
  let color: String
  let isPrimary: Bool
}

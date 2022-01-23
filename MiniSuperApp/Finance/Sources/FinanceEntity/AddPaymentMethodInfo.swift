//
//  AddPaymentMethodInfo.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/12/04.
//

import Foundation

public struct AddPaymentInfo {
  public let number: String
  public let cvc: String
  public let expiry: String
  
  public init(
    number: String,
    cvc: String, 
    expiry: String
  ) {
    self.number = number
    self.cvc = cvc
    self.expiry = expiry
  }
}

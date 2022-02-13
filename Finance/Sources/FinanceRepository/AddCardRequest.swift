//
//  AddCardRequest.swift
//  
//
//  Created by 문효재 on 2022/02/13.
//

import Foundation
import Network
import FinanceEntity

struct AddCardRequest: Request {
  typealias Output = AddCardResponse
  
  var endpoint: URL
  var method: HTTPMethod
  var query: QueryItems
  var header: HTTPHeader
  
  init(baseURL: URL, info: AddPaymentInfo) {
    self.endpoint = baseURL.appendingPathComponent("/addCard")
    self.method = .post
    self.query = [
      "number": info.number,
      "cvc": info.cvc,
      "expiry": info.expiry
    ]
    self.header = [:]
  }
}

struct AddCardResponse: Decodable {
  let card: PaymentMethod
}

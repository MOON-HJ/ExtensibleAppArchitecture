//
//  TopupRequest.swift
//  
//
//  Created by 문효재 on 2022/02/13.
//

import Foundation
import Network

struct TopupRequest: Request {
  typealias Output = TopupResponse
  
  var endpoint: URL
  var method: HTTPMethod
  var query: QueryItems
  var header: HTTPHeader
  
  init(baseURL: URL, amount: Double, paymentMethodID: String) {
    self.endpoint = baseURL.appendingPathComponent("/topup")
    self.method = .post
    self.query = [
      "amount": amount,
      "paymentMethodID": paymentMethodID
    ]
    self.header = [:]
  }
}


struct TopupResponse: Decodable {
  let status: String
}

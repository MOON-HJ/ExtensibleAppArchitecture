//
//  SetupURLProtocol.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2022/02/13.
//

import Foundation

func setupURLProtocol() {
  let topupResponse: [String: Any] = [
    "status": "success"
  ]
  
  let topupResponseData = try! JSONSerialization.data(withJSONObject: topupResponse, options: [])
  let addCardResponse: [String: Any] = [
    "card": [
      "id": "999",
      "name": "새 카드",
      "digits": "**** 0101",
      "color": "",
      "isPrimary": false
    ]
  ]
  let addCardResponseData = try! JSONSerialization.data(withJSONObject: addCardResponse, options: [])
  
  SuperAppURLProtocol.successMock = [
    "/api/v1/topup": (200, topupResponseData),
    "/api/v1/addCard": (200, addCardResponseData),
  ]
}

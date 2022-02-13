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
  
  let cardOnFileResponse: [String: Any] = [
    "cards":[
      ["id": "0",
       "name": "우리은행",
       "digits": "0123",
       "color": "#F19A38FF",
       "isPrimary": false],
      ["id": "1",
       "name": "신한카드",
       "digits": "5672",
       "color": "#3478F6FF",
       "isPrimary": false],
      ["id": "2",
       "name": "현대카드",
       "digits": "4567",
       "color": "#78C5F5FF",
       "isPrimary": false],
      ["id": "3",
       "name": "국민은행",
       "digits": "1234",
       "color": "#65C466FF",
       "isPrimary": false],
      ["id": "4",
       "name": "카카오뱅크",
       "digits": "6455",
       "color": "#FFCC00FF",
       "isPrimary": false]
    ]
  ]
  let cardOnFileResponseData = try! JSONSerialization.data(withJSONObject: cardOnFileResponse, options: [])
  
  
  SuperAppURLProtocol.successMock = [
    "/api/v1/topup": (200, topupResponseData),
    "/api/v1/addCard": (200, addCardResponseData),
    "/api/v1/cards": (200, cardOnFileResponseData),
  ]
}

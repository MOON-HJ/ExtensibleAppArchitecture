//
//  BaseURL.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2022/02/13.
//

import Foundation

struct BaseURL {
  var financeBaseURL: URL {
    return URL(string: "https://finance.superapp.com/api/v1")!
  }
}

//
//  BaseURL.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2022/02/13.
//

import Foundation

struct BaseURL {
  
  var financeBaseURL: URL {
#if UITEST
    return URL(string: "http://localhost:8080")!
#else
    return URL(string: "https://finance.superapp.com/api/v1")!
#endif
  }
}

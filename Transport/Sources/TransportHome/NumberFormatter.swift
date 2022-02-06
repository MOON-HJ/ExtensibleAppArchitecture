//
//  NumberFormatter.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2022/02/06.
//

import Foundation

struct Formatter {
  static let balanceFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
  }()
}

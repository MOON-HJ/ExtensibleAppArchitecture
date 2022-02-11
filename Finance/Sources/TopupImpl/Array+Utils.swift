//
//  Array+Utils.swift
//  
//
//  Created by 문효재 on 2022/02/06.
//

import Foundation

extension Array {
  subscript(safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
}

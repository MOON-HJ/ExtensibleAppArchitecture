//
//  Array+Utils.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/12/11.
//
import Foundation

extension Array {
  subscript(safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
}

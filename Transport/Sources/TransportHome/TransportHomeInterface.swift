//
//  TransportHomeInterface.swift
//  
//
//  Created by 문효재 on 2022/02/07.
//

import Foundation
import ModernRIBs

public protocol TransportHomeBuildable: Buildable {
  func build(withListener listener: TransportHomeListener) -> ViewableRouting
}

public protocol TransportHomeListener: AnyObject {
  func transportHomeDidTapClose()
}

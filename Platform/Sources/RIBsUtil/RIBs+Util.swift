//
//  RIBs+Util.swift
//  
//
//  Created by 문효재 on 2022/01/29.
//

import Foundation

public enum DismissButtonType {
  case back
  case close
  
  public var iconSystemName: String {
    switch self {
    case .back:
      return "chevron.backward"
    case .close:
      return "xmark"
    }
  }
}

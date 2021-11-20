//
//  PaymentMethodViewModel.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/11/20.
//

import UIKit


struct PaymentMethodViewModel {
  let name: String
  let digits: String
  let color: UIColor
  
  init(_ paymentMethod: PaymentMethod) {
    name = paymentMethod.name
    digits = "**** \(paymentMethod.digits)"
    color = UIColor(hex: paymentMethod.color) ?? .systemGray2
  }
}

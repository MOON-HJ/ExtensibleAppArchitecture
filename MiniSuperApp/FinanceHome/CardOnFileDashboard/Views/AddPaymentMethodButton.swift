//
//  AddPaymentMethodButton.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/11/20.
//

import UIKit

final class AddPaymentMethodButton: UIControl {
  private let plusIcon: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)))
    imageView.tintColor = .white
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  init() {
    super.init(frame: .zero)
    self.setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(frame: .zero)
    self.setupViews()
  }
  
  private func setupViews() {
    addSubview(plusIcon)
    
    NSLayoutConstraint.activate([
      plusIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      plusIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}

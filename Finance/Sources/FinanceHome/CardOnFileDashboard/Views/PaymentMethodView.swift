//
//  PaymentMethodView.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/11/20.
//

import UIKit

final class PaymentMethodView: UIView {
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 18, weight: .semibold)
    label.textColor = .white
    return label
  }()
  
  private let subTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    return label
  }()
  
  init(viewModel: PaymentMethodViewModel) {
    super.init(frame: .zero)
    self.setupViews()
    
    nameLabel.text = viewModel.name
    subTitleLabel.text = viewModel.digits
    backgroundColor = viewModel.color
  }
  
  required init?(coder: NSCoder) {
    super.init(frame: .zero)
    self.setupViews()
  }
  
  private func setupViews() {
    [nameLabel, subTitleLabel].forEach {
      self.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
      nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      
      subTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
      subTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }

}

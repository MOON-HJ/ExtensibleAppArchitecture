//
//  SuperPayDashBoardViewController.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/10/31.
//

import ModernRIBs
import UIKit

protocol SuperPayDashBoardPresentableListener: AnyObject {
  func topupButtonDidTap()
}

final class SuperPayDashBoardViewController: UIViewController, SuperPayDashBoardPresentable, SuperPayDashBoardViewControllable {

    weak var listener: SuperPayDashBoardPresentableListener?
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "슈퍼페이 잔고"
        return label
    }()
    
    private let topupButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("충전하기", for: .normal)
      button.accessibilityIdentifier = "superpay_dashboard_topup_button"
        button.setTitleColor(.systemBlue , for: .normal)
        button.addTarget(self, action: #selector(topupButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius  = 16
        view.layer.cornerCurve = .continuous
        view.backgroundColor = .systemIndigo
        return view
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "원"
        label.textColor = .white
        return label
    }()
    
    private let balanceAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        label.text = "100,000"
        label.accessibilityIdentifier = "superpay_dashboard_balance_label"
        return label
    }()
    
    private let balanceStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        [headerStackView, cardView].forEach {
            self.view.addSubview($0)
        }
        
        [balanceStackView].forEach {
            cardView.addSubview($0)
        }
        
        [balanceAmountLabel, currencyLabel].forEach {
            balanceStackView.addArrangedSubview($0)
        }
        
        [titleLabel, topupButton].forEach {
            self.headerStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            cardView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 10),
            cardView.heightAnchor.constraint(equalToConstant: 180),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            balanceStackView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            balanceStackView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)

        ])
    }
    
    @objc
    private func topupButtonDidTap() {
      listener?.topupButtonDidTap()
    }
  
  func updateBalance(_ balance: String) {
    self.balanceAmountLabel.text = balance
  }
}

//
//  UIViewController+Utils.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/12/11.
//

import UIKit
import RIBsUtil 

public extension UIViewController {
  func setupNavigationItem(with buttonType: DismissButtonType, target: Any?, action: Selector?) {
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(
        systemName: buttonType.iconSystemName,
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
      ),
      style: .plain,
      target: target,
      action: action
    )
  }
}

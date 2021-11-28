//
//  AdaptivePresentationControllerDelegate.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2021/11/28.
//

import UIKit

protocol AdaptivePresentationControllerDelegate: AnyObject {
  func presentationControllerDidDismiss()
}

final class AdaptivePresentationControllerDelegateProxy: NSObject, UIAdaptivePresentationControllerDelegate {
  weak var delegate: AdaptivePresentationControllerDelegate?
  
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    delegate?.presentationControllerDidDismiss()
  }
}

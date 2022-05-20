//
//  UIView+Extension.swift
//  Geek
//
//  Created by Srikanth S on 20/05/22.
//

import UIKit

extension UIView {

  func dropShadow() {
      layer.shadowColor = UIColor.lightGray.cgColor
      layer.shadowOpacity = 1
      layer.shadowOffset = CGSize.zero
      layer.shadowRadius = 5
      layer.cornerRadius = 10
    
  }
}

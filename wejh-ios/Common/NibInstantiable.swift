//
//  NibInstantiable.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/5.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

protocol NibInstantiable: UIView {

  static var nibName: String { get }
  static var nib: UINib { get }

}

extension NibInstantiable {

  static var nibName: String {
    return String(describing: self)
  }

  static var nib: UINib {
    return UINib(nibName: nibName, bundle: nil)
  }

}

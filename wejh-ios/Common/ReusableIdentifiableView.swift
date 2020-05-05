//
//  ReusableIdentifiableView.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/5.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//


import UIKit

protocol ReusableIdentifiableView: UIView {

  static var reuseIdentifier: String { get }

}

extension ReusableIdentifiableView {

  static var reuseIdentifier: String {
    return String(describing: self)
  }

}

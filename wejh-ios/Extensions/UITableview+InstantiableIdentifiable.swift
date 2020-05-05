//
//  UITableview+InstantiableIdentifiable.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/5.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

protocol InstantiableIdentifiable: NibInstantiable & ReusableIdentifiableView {

}

extension UITableView {

  func register<T: InstantiableIdentifiable>(_ ViewClass: T.Type) {
    self.register(ViewClass.nib, forCellReuseIdentifier: ViewClass.nibName)
  }

}

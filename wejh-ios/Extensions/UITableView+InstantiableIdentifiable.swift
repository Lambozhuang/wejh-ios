//
//  UITableView+InstantiableIdentifiable.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/5.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

protocol InstantiableIdentifiable: NibInstantiable & ReusableIdentifiableView {

}

extension UITableView {

  func registerCell<T: InstantiableIdentifiable>(_ CellClass: T.Type) {
    self.register(CellClass.nib, forCellReuseIdentifier: CellClass.reuseIdentifier)
  }

  func registerHeaderFooter<T: InstantiableIdentifiable>(_ ViewClass: T.Type) {
    self.register(ViewClass.nib, forHeaderFooterViewReuseIdentifier: ViewClass.reuseIdentifier)
  }

}

extension UICollectionView {

  func registerCell<T: InstantiableIdentifiable>(_ CellClass: T.Type) {
    self.register(CellClass.nib, forCellWithReuseIdentifier: CellClass.reuseIdentifier)
  }

}

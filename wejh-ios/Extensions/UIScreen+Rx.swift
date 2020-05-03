//
//  UIScreen+Rx.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/3.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIScreen {

  var traitCollectionDidChange: ControlEvent<UITraitCollection> {
    let source = self.methodInvoked(#selector(Base.traitCollectionDidChange)).map { _ in
      return self.base.traitCollection
    }
    return ControlEvent(events: source)
  }

  var traitCollection: Observable<UITraitCollection> {
    let updatedLocation = self.traitCollectionDidChange
    return updatedLocation.startWith(self.base.traitCollection)
  }

}

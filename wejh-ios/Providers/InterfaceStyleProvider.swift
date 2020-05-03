//
// Created by Bunny Wong on 2020/5/3.
// Copyright (c) 2020 Bunny Wong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FluentDarkModeKit

enum InterfaceStyle: Int {

  case light = 1
  case dark = 2

  var userInterfaceStyle: DMUserInterfaceStyle? {
    return DMUserInterfaceStyle(rawValue: rawValue)
  }

}

class InterfaceStyleProvider {

  static let `default` = InterfaceStyleProvider()

  var currentInterfaceStyle: Driver<InterfaceStyle>!

  private lazy var currentInterfaceStylePreference = InterfaceStylePreferenceService.shared.current
  private var disposeBag = DisposeBag()

  init() {
    currentInterfaceStyle = currentInterfaceStylePreference.flatMap { preference -> Observable<InterfaceStyle> in
      switch preference {
      case .followSystem:
        return UIScreen.main.rx.traitCollection.map { traitCollection in
          switch traitCollection.userInterfaceStyle {
          case .dark:
            return .dark
          default:
            return .light
          }
        }
      case .light:
        return Observable.just(.light)
      case .dark:
        return Observable.just(.dark)
      }
    }.distinctUntilChanged().asDriverOnErrorJustComplete()
  }

}

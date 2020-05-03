//
//  Application.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/1.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit
import RxSwift
import FluentDarkModeKit

final class Application {

  static let shared = Application()

  private let navigator: Navigator = Navigator.default
  private let disposeBag = DisposeBag()

  private var shouldAnimateOnAppearanceChange = false

  func setupThirdPartyLibs() {
    DarkModeManager.setup()
    startObservingInterfaceStyle()
  }

  func startObservingInterfaceStyle() {
    InterfaceStyleProvider.default.currentInterfaceStyle.drive(onNext: { interfaceStyle in
      guard let userInterfaceStyle = interfaceStyle.userInterfaceStyle else {
        return
      }
      DMTraitCollection.current = DMTraitCollection(userInterfaceStyle: userInterfaceStyle)
      DarkModeManager.updateAppearance(for: UIApplication.shared, animated: self.shouldAnimateOnAppearanceChange)
      self.shouldAnimateOnAppearanceChange = true
    }).disposed(by: self.disposeBag)
  }

  func presentHomeScene(in window: UIWindow) {
    let homeViewModel = HomeViewModel()
    navigator.transition(to: .home(viewModel: homeViewModel), type: .root(in: window), sender: nil)
  }

}

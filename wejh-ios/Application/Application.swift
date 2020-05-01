//
//  Application.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/1.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

final class Application {

  static let shared = Application()

  private let navigator: Navigator = Navigator.default

  func presentHomeScene(in window: UIWindow) {
    let homeViewModel = HomeViewModel()
    navigator.transition(to: .home(viewModel: homeViewModel), type: .root(in: window), sender: nil)
  }

}

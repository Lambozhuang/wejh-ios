//
//  AppDelegate.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/1.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  static var shared: AppDelegate? {
    return UIApplication.shared.delegate as? AppDelegate
  }

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    guard let window = window else {
      fatalError("Application should have a window.Application")
    }
    Application.shared.presentHomeScene(in: window)

    return true
  }

}

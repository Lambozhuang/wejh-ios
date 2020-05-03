//
//  Navigator.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/1.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit
import WhatsNewKit

protocol Navigable {
  var navigator: Navigator! { get }
}

final class Navigator {

  static let `default` = Navigator()

  enum Scene {
    case home(viewModel: HomeViewModel)
    case whatsNew(traits: WhatsNewTraits)
  }

  enum SceneTransitionType {
    case root(in: UIWindow)
    case push
    case modal
  }

  lazy var mainStoryboard: UIStoryboard = {
    return UIStoryboard(name: "Main", bundle: nil)
  }()

  func transition(to scene: Scene, type: SceneTransitionType, sender: UIViewController?) {
    guard let destinationController = getViewController(for: scene) else {
      return
    }
    switch type {
    case .root(let window):
      window.rootViewController = getViewController(for: scene)
    case .push:
      guard let navigationController = sender as? UINavigationController else {
        return
      }
      navigationController.pushViewController(destinationController, animated: true)
    case .modal:
      guard let sender = sender else {
        return
      }
      sender.present(destinationController, animated: true, completion: nil)
    }
  }

  func getViewController(for scene: Scene) -> UIViewController? {
    switch scene {
    case .home(let viewModel):
      let nc = HomeViewController.instance(for: mainStoryboard) as! UINavigationController
      let vc = nc.viewControllers.first as! HomeViewController
      vc.connect(viewModel: viewModel, navigator: self)
      return nc
    case .whatsNew(traits: (let items, let configuration, let versionStore)):
      let whatsNewController = WhatsNewViewController(whatsNew: items, configuration: configuration, versionStore: versionStore)
      return whatsNewController
    }
  }

}

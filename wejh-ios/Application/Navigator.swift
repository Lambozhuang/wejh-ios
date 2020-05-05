//
//  Navigator.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/1.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit
import WhatsNewKit

final class Navigator {

  static let `default` = Navigator()

  enum Scene<Navigable: NavigableControllerType> {
    case navigable(viewModel: Navigable.ViewModel)
    case whatsNew(traits: WhatsNewTraits)
  }

  enum SceneTransitionType {
    case root(in: UIWindow, embedInNavigation: Bool = true)
    case push
    case modal(embedInNavigation: Bool = true)
  }

  lazy var mainStoryboard: UIStoryboard = {
    return UIStoryboard(name: "Main", bundle: nil)
  }()

  func transition<Navigable: NavigableControllerType>(to scene: Scene<Navigable>, type: SceneTransitionType, sender: UIViewController?) {
    guard let destinationController = getViewController(for: scene) else {
      return
    }
    switch type {
    case .root(let window, let embedInNavigation):
      window.rootViewController = embedInNavigation ? UINavigationController(rootViewController: destinationController) : destinationController
    case .push:
      guard let navigationController = sender as? UINavigationController else {
        return
      }
      navigationController.pushViewController(destinationController, animated: true)
    case .modal(let embedInNavigation):
      guard let sender = sender else {
        return
      }
      let destination = embedInNavigation ? UINavigationController(rootViewController: destinationController) : destinationController
      sender.present(destination, animated: true, completion: nil)
    }
  }

}

extension Navigator {

  func getViewController<Navigable: NavigableControllerType>(for scene: Scene<Navigable>) -> UIViewController? {
    switch scene {
    case .navigable(let viewModel):
      let vc = Navigable.init(viewModel: viewModel, navigator: self)
      return vc
    case .whatsNew(traits: (let items, let configuration, let versionStore)):
      let whatsNewController = WhatsNewViewController(whatsNew: items, configuration: configuration, versionStore: versionStore)
      return whatsNewController
    }
  }

}

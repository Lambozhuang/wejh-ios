//
//  WhatsNewProvider.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/1.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import WhatsNewKit

typealias WhatsNewConfiguration = WhatsNewViewController.Configuration

typealias WhatsNewTraits = (WhatsNew, WhatsNewConfiguration, KeyValueWhatsNewVersionStore)

class WhatsNewProvider {

  static let `default` = WhatsNewProvider()

  private lazy var whatsNewItems: WhatsNew? = {
    let decoder = JSONDecoder()
    guard let path = Bundle.main.path(forResource: "whats-new", ofType: "json"),
          let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
          let items = try? decoder.decode(WhatsNew.self, from: data) else {
      return nil
    }
    return items
  }()

  private lazy var configuration: WhatsNewConfiguration = {
    let theme = WhatsNewViewController.Theme { configuration in
      configuration.backgroundColor = UIColor(.dm, light: .white, dark: .black)
      configuration.titleView.titleColor = .primaryPink
      configuration.itemsView.subtitleFont = .systemFont(ofSize: 14, weight: .semibold)
      configuration.detailButton?.titleColor = .white
      configuration.detailButton?.title = "继续"
      configuration.completionButton.backgroundColor = .primaryPink
    }
    return WhatsNewViewController.Configuration(theme: theme)
  }()

  func traits() -> WhatsNewTraits? {
    guard let items = self.whatsNewItems else {
      return nil
    }
    let configuration = self.configuration
    let userDefaultsVersionStore = KeyValueWhatsNewVersionStore(keyValueable: UserDefaults.standard, prefixIdentifier: Bundle.main.bundleIdentifier ?? "")

    return (items, configuration, userDefaultsVersionStore)
  }

}

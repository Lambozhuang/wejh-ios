//
//  StoryboardInstantiable.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/1.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

protocol StoryboardInstantiatable: UIViewController {

  static var storyboardIdentifier: String { get }

}

extension StoryboardInstantiatable {

  static func instance(for storyboard: UIStoryboard) -> UIViewController {
    return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier)
  }

}

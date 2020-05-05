//
//  String+Localized.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/5.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import Foundation

extension String {

  var localized: String {
    return NSLocalizedString(self, comment: "")
  }

}

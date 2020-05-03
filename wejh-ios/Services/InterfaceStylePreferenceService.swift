//
//  InterfaceStylePreferenceService.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/3.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import RxSwift
import RxRelay

enum InterfaceStylePreference {
  case light
  case dark
  case followSystem
}

// 这个类可以取到当前的主题偏好，并且可以修改和存储
class InterfaceStylePreferenceService {

  static let shared = InterfaceStylePreferenceService()

  var current = BehaviorRelay<InterfaceStylePreference>(value: .followSystem)

  init() {

  }

}

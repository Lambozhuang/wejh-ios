//
//  HomeViewModel.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/1.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftExt

final class HomeViewModel: ComplexViewModelType {

  struct Input {
    let whatsNewTrigger: Observable<Void>
    let userSceneTrigger: ControlEvent<Void>
  }

  struct Output {
    let presentWhatsNew: Driver<WhatsNewTraits?>
    let presentUserScene: Driver<UserViewModel>
  }

  func transform(input: Input) -> Output {
    let whatsNewTraits = input.whatsNewTrigger.map({ return WhatsNewProvider.default.traits() })
    let userViewModel = input.userSceneTrigger.map({ return UserViewModel() })
    return Output(presentWhatsNew: whatsNewTraits.asDriverOnErrorJustComplete(),
        presentUserScene: userViewModel.asDriverOnErrorJustComplete())
  }

}

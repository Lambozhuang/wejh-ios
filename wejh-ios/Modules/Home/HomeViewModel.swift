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

class HomeViewModel: ViewModelType {

  struct Input {
    let whatsNewTrigger: Observable<Void>
  }

  struct Output {
    let presentWhatsNew: Driver<WhatsNewTraits?>
  }

  func transform(input: Input) -> Output {
    let whatsNewTraits = input.whatsNewTrigger.take(1).map( { WhatsNewProvider.default.traits() } )
    return Output(presentWhatsNew: whatsNewTraits.asDriver(onErrorJustReturn: nil))
  }

}

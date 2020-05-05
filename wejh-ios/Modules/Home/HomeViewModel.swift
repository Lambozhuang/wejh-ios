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
import RxDataSources

struct HomeTodaySectionModel: SectionModelType {

  typealias Item = HomeTodayCellViewModel

  var items: [Item]

  init(items: [Item]) {
    self.items = items
  }

  init(original: HomeTodaySectionModel, items: [Item]) {
    self = original
    self.items = items
  }

}

final class HomeViewModel: ComplexViewModelType {

  struct Input {
    let whatsNewTrigger: Observable<Void>
    let userSceneTrigger: ControlEvent<Void>
  }

  struct Output {
    let presentWhatsNew: Driver<WhatsNewTraits?>
    let presentUserScene: Driver<UserViewModel>

    let todaySecion: Driver<[HomeTodaySectionModel]>
  }

  func transform(input: Input) -> Output {
    let whatsNewTraits = input.whatsNewTrigger.map({ return WhatsNewProvider.default.traits() })
    let userViewModel = input.userSceneTrigger.map({ return UserViewModel() })

    let todaySection = Observable.just([HomeTodaySectionModel(items: [HomeTodayCellCardViewModel()])])

    return Output(presentWhatsNew: whatsNewTraits.asDriverOnErrorJustComplete(),
                  presentUserScene: userViewModel.asDriverOnErrorJustComplete(),
                  todaySecion: todaySection.asDriverOnErrorJustComplete())
  }

}

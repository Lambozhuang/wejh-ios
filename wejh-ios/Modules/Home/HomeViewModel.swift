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

  init(original: Self, items: [Item]) {
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

    let todaySection: Driver<[HomeTodaySectionModel]>
    let menu: Driver<HomeMenuViewModel>
  }

  func transform(input: Input) -> Output {
    let whatsNewTraits = input.whatsNewTrigger.map({ return WhatsNewProvider.default.traits() })
    let userViewModel = input.userSceneTrigger.map({ return UserViewModel() })

    let todaySection = Observable.just([
      HomeTodaySectionModel(items: [
        HomeTodayCellCardViewModel(),
        HomeTodayCellTimetableViewModel(events: [
          HomeTodayCellTimetableViewModel.EventViewModel(eventName: "高等数学", eventTime: "9:55-11:35", eventSchedule: "1-16周 3-4节", eventLocation: "广A102"),
          HomeTodayCellTimetableViewModel.EventViewModel(eventName: "线性代数", eventTime: "1:30-15:10", eventSchedule: "1-8周 6-7节", eventLocation: "广B303")
        ])
      ]),
    ])

    let menu = HomeMenuViewModel(menuItems: [
      MenuItemViewModel(name: "我的课表", imageName: "Images/menu-timetable"),
      MenuItemViewModel(name: "我的成绩", imageName: "Images/menu-score"),
      MenuItemViewModel(name: "考试安排", imageName: "Images/menu-exam"),
      MenuItemViewModel(name: "我的借阅", imageName: "Images/menu-library"),
      MenuItemViewModel(name: "校园卡", imageName: "Images/menu-card"),
      MenuItemViewModel(name: "空闲教室", imageName: "Images/menu-classroom"),

      MenuItemViewModel(name: "我的课表", imageName: "Images/menu-timetable"),
      MenuItemViewModel(name: "我的成绩", imageName: "Images/menu-score"),
      MenuItemViewModel(name: "考试安排", imageName: "Images/menu-exam"),
      MenuItemViewModel(name: "我的借阅", imageName: "Images/menu-library"),
      MenuItemViewModel(name: "校园卡", imageName: "Images/menu-card"),
      MenuItemViewModel(name: "空闲教室", imageName: "Images/menu-classroom"),

      MenuItemViewModel(name: "我的课表", imageName: "Images/menu-timetable"),
      MenuItemViewModel(name: "我的成绩", imageName: "Images/menu-score"),
      MenuItemViewModel(name: "考试安排", imageName: "Images/menu-exam"),
      MenuItemViewModel(name: "我的借阅", imageName: "Images/menu-library"),
      MenuItemViewModel(name: "校园卡", imageName: "Images/menu-card"),
      MenuItemViewModel(name: "空闲教室", imageName: "Images/menu-classroom"),
    ])

    return Output(presentWhatsNew: whatsNewTraits.asDriverOnErrorJustComplete(),
        presentUserScene: userViewModel.asDriverOnErrorJustComplete(),
        todaySection: todaySection.asDriverOnErrorJustComplete(),
        menu: Driver.just(menu)
    )
  }

}

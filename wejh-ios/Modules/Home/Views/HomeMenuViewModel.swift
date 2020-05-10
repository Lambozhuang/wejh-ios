//
//  HomeMenuViewModel.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/7.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import RxSwift
import RxCocoa
import RxRelay
import RxDataSources
import NSObject_Rx

struct MenuItemViewModel {

  var name: String
  var imageName: String

}

final class HomeMenuViewModel: ComplexViewModelType {

  struct PagedMenuItems: SectionModelType {

    typealias Item = MenuItemViewModel

    var items: [Item]

    init(items: [Item]) {
      self.items = items
    }

    init(original: Self, items: [Item]) {
      self = original
      self.items = items
    }

  }

  struct Input {
  }

  struct Output {
    var pagedMenuItems: Observable<[PagedMenuItems]>
  }

  var itemsPerRow = 3
  var itemsPerColumn = 2

  var menuItems: BehaviorRelay<[MenuItemViewModel]>

  init(menuItems: [MenuItemViewModel]) {
    self.menuItems = BehaviorRelay(value: menuItems)
  }

  func transform(input: Input) -> Output {
    let pagedItems = menuItems.map { items -> [PagedMenuItems] in
      let pageSize = self.itemsPerRow * self.itemsPerColumn
      let pages = items.chunked(by: pageSize).map { page in
        return PagedMenuItems(items: page)
      }
      return pages
    }
    return Output(pagedMenuItems: pagedItems)
  }

}

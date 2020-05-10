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

struct MenuItem {

  var name: String
  var imageName: String

}

enum MenuItemOrEmpty {

  case item(name: String, imageName: String)
  case empty

}

final class HomeMenuViewModel: ComplexViewModelType {

  struct PagedMenuItems: SectionModelType {

    typealias Item = MenuItemOrEmpty

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

  var menuItems: BehaviorRelay<[MenuItem]>

  init(menuItems: [MenuItem]) {
    self.menuItems = BehaviorRelay(value: menuItems)
  }

  func transform(input: Input) -> Output {
    let pageSize = itemsPerRow * itemsPerColumn

    // Observable mapping
    let pages = menuItems.map { items -> [PagedMenuItems] in
      // Chunk items, [MenuItemOrEmpty] for every group
      let reorderedItems = items.chunked(by: pageSize).map { items -> [MenuItemOrEmpty] in
        var res = [MenuItemOrEmpty]()
        for idx in 0..<pageSize {
          let y = idx % self.itemsPerColumn
          let x = idx / self.itemsPerColumn
          let newIndex = y * self.itemsPerRow + x
          if newIndex < items.count {
            let item = items[newIndex]
            res.append(MenuItemOrEmpty.item(name: item.name, imageName: item.imageName))
          } else {
            res.append(MenuItemOrEmpty.empty)
          }
        }
        return res
      }
      return reorderedItems.map({ PagedMenuItems(items: $0) })
    }
    return Output(pagedMenuItems: pages)
  }

}

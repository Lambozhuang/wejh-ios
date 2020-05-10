//
//  HomeTodayCellTimetable.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/5.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit
import NSObject_Rx
import SnapKit

final class EventTableView: UITableView {

  override var intrinsicContentSize: CGSize {
      self.layoutIfNeeded()
      return self.contentSize
  }

  override var contentSize: CGSize {
      didSet{
          self.invalidateIntrinsicContentSize()
      }
  }

  override func reloadData() {
      super.reloadData()
      self.invalidateIntrinsicContentSize()
  }

}

final class HomeTodayCellTimetable: HomeTodayCellBase<HomeTodayCellTimetableViewModel>, InstantiableIdentifiable {

  typealias ViewModel = HomeTodayCellTimetableViewModel

  @IBOutlet weak var eventsTableView: EventTableView!

  override func setupUI() {
    super.setupUI()
    titleLabel.text = "home-today-timetable-title".localized
    eventsTableView.registerCell(HomeTodayCellTimetableEventCell.self)
    eventsTableView.separatorColor = .clear
    eventsTableView.isScrollEnabled = false
    eventsTableView.allowsSelection = false
    eventsTableView.rowHeight = 56
    eventsTableView.estimatedRowHeight = 56
    eventsTableView.backgroundColor = .clear
  }

  override func bindToViewModel() {
    guard let viewModel = viewModel else {
      return
    }
    eventsTableView.invalidateIntrinsicContentSize()

//    viewModel.events.asDriver().drive(onNext: { event in
//      self.eventsTableView.snp.makeConstraints { make in
//        make.height.equalTo(event.count * 56) 
//      }
//    }).disposed(by: rx.disposeBag)

    eventsTableView.delegate = nil
    eventsTableView.dataSource = nil

    viewModel.events.bind(to: eventsTableView.rx.items(cellIdentifier: HomeTodayCellTimetableEventCell.reuseIdentifier,
                                                       cellType: HomeTodayCellTimetableEventCell.self)) { _, model, cell in
      cell.connect(viewModel: model)
    }.disposed(by: rx.disposeBag)
  }

}

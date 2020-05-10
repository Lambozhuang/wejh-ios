//
//  HomeTodayCellTimetableEventCell.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/5.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

final class HomeTodayCellTimetableEventCell: UITableViewCell, InstantiableIdentifiable, ViewModelBindableType {

  var viewModel: HomeTodayCellTimetableViewModel.EventViewModel?

  typealias ViewModel = HomeTodayCellTimetableViewModel.EventViewModel

  @IBOutlet weak var eventNameLabel: UILabel!
  @IBOutlet weak var timeIconImageView: UIImageView!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var scheduleLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = .clear
  }

  func connect(viewModel: HomeTodayCellTimetableViewModel.EventViewModel?) {
    self.viewModel = viewModel
    bindToViewModel()
  }

  func bindToViewModel() {
    guard let viewModel = viewModel else {
      return
    }
    eventNameLabel.text = viewModel.eventName
    timeLabel.text = viewModel.eventTime
    scheduleLabel.text = viewModel.eventSchedule
    locationLabel.text = viewModel.eventLocation
  }

}

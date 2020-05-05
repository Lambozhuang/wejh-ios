//
//  HomeTodayCell.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/4.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

class HomeTodayCellBase: UITableViewCell {

  @IBOutlet weak var titleIconImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var updatedLabel: UILabel!

}

final class HomeTodayCellTimetable: HomeTodayCellBase, InstantiableIdentifiable {

  @IBOutlet weak var todayCurriculumTableView: UITableView!

}

final class HomeTodayCellTimetableEvent: UITableViewCell, InstantiableIdentifiable {

  @IBOutlet weak var eventNameLabel: UILabel!
  @IBOutlet weak var timeIconImageView: UIImageView!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var scheduleLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!

}

final class HomeTodayCellCard: HomeTodayCellBase, InstantiableIdentifiable {

  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var balanceLabel: UILabel!
  @IBOutlet weak var balanceUnitLabel: UILabel!

}

final class HomeTodayCellLibrary: HomeTodayCellBase, InstantiableIdentifiable {

}

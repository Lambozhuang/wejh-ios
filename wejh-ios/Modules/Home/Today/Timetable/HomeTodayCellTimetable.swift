//
//  HomeTodayCellTimetable.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/5.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

final class HomeTodayCellTimetable: HomeTodayCellBase<HomeTodayCellTimetableViewModel>, InstantiableIdentifiable {

  typealias ViewModel = HomeTodayCellTimetableViewModel

  @IBOutlet weak var todayCurriculumTableView: UITableView!

  override func bindToViewModel() {

  }

}

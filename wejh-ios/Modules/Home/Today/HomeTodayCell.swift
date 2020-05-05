//
//  HomeTodayCell.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/4.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

class HomeTodayCellBase<ViewModel: ViewModelType>: UITableViewCell, ViewModelBindableType {

  private(set) var viewModel: ViewModel?

  @IBOutlet weak var titleIconImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var updatedLabel: UILabel!

  func connect(viewModel: ViewModel?) {
    self.viewModel = viewModel
    bindToViewModel()
  }

  func bindToViewModel() {

  }

}

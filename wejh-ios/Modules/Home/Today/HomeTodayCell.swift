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

  @IBOutlet weak var shadowView: UIView!
  @IBOutlet weak var containerView: UIView!

  @IBOutlet weak var titleIconImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var updatedLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }

  func connect(viewModel: ViewModel?) {
    self.viewModel = viewModel
    bindToViewModel()
  }

  func setupUI() {
    backgroundColor = .clear
    clipsToBounds = false
    contentView.clipsToBounds = false

    shadowView.layer.cornerRadius = 16
    containerView.layer.cornerRadius = 16
    containerView.layer.masksToBounds = true

    shadowView.layer.shadowColor = UIColor.shadowBlack.cgColor
    shadowView.layer.shadowOpacity = 0.05
    shadowView.layer.shadowOffset = .init(width: 0, height: 8)
    shadowView.layer.shadowRadius = 20
  }

  func bindToViewModel() {

  }

}

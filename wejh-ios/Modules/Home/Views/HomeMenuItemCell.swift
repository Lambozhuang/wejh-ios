//
//  HomeMenuItemCell.swift
//  wejh-ios
//
//  created by Bunny Wong on 2020/5/7.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

final class HomeMenuItemCell: UICollectionViewCell, InstantiableIdentifiable {

  @IBOutlet weak var shadowView: UIView!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var itemImageView: UIImageView!
  @IBOutlet weak var itemLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    shadowView.layer.cornerRadius = 16
    containerView.layer.cornerRadius = 16
    containerView.layer.masksToBounds = true

    shadowView.layer.shadowColor = UIColor.shadowBlack.cgColor
    shadowView.layer.shadowOpacity = 0.05
    shadowView.layer.shadowOffset = .init(width: 0, height: 8)
    shadowView.layer.shadowRadius = 20
  }

}

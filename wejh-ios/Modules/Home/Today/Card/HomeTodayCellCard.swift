//
//  HomeTodayCellCard.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/5.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

final class HomeTodayCellCard: HomeTodayCellBase<HomeTodayCellCardViewModel>, InstantiableIdentifiable {

  typealias ViewModel = HomeTodayCellCardViewModel

  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var balanceLabel: UILabel!
  @IBOutlet weak var balanceUnitLabel: UILabel!

  func setupUI() {
  }

  override func connect(viewModel: HomeTodayCellCardViewModel?) {

  }

  override func bindToViewModel() {
    guard let viewModel = viewModel else {
      return
    }
    viewModel.balance.bind(to: balanceLabel.rx.text).disposed(by: rx.disposeBag)
  }

}

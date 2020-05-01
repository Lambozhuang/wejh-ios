//
//  ViewControllerType.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/1.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

class BaseViewController<ViewModel: ViewModelType>: UIViewController, Navigable {

  var navigator: Navigator!
  var viewModel: ViewModel?

  init(viewModel: ViewModel?, navigator: Navigator!) {
    super.init(nibName: nil, bundle: nil)
    connect(viewModel: viewModel, navigator: navigator)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  func connect(viewModel: ViewModel?, navigator: Navigator) {
    self.viewModel = viewModel
    self.navigator = navigator
  }

  func setupUI() {

  }

  func bindToViewModel() {

  }

}

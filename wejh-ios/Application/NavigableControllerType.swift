//
//  NavigableControllerType.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/5.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

protocol NavigableControllerType: UIViewController, ViewModelBindableType {

  var navigator: Navigator! { get }

  init(viewModel: ViewModel, navigator: Navigator)

  func connect(viewModel: ViewModel?, navigator: Navigator)

}

/// Dummy type for `Navigator.Scene` enum, since swift compiler has to determine the whole type regarding of which case used
class DummyNavigable: UIViewController, NavigableControllerType {

  typealias ViewModel = DummyViewModel

  var navigator: Navigator!
  var viewModel: DummyViewModel?

  required init(viewModel: ViewModel, navigator: Navigator) {
    fatalError("init(viewModel:, navigator:) has not been implemented")
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func connect(viewModel: ViewModel?, navigator: Navigator) {
    fatalError("connect(viewModel:, navigator:) has not been implemented")
  }

  func connect(viewModel: DummyViewModel?) {

  }

  func bindToViewModel() {

  }

  struct DummyViewModel: ViewModelType {

  }

}

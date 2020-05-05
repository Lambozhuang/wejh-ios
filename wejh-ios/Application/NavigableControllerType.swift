//
//  NavigableControllerType.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/5.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

protocol NavigableControllerType: UIViewController {

  associatedtype ViewModel: ViewModelType

  var navigator: Navigator! { get set }
  var viewModel: ViewModel? { get set }

  init(viewModel: ViewModel, navigator: Navigator)

  func connect(viewModel: ViewModel?, navigator: Navigator)

}

/// Dummy type for `Navigator.Scene` enum, since swift compiler has to determine the whole type regarding of which case used
class DummyNavigable: UIViewController, NavigableControllerType {

  var navigator: Navigator!
  var viewModel: DummyViewModel?

  required init(viewModel: DummyViewModel, navigator: Navigator) {
    fatalError("init(viewModel:, navigator:) has not been implemented")
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func connect(viewModel: DummyViewModel?, navigator: Navigator) {
    fatalError("connect(viewModel:, navigator:) has not been implemented")
  }

  typealias ViewModel = DummyViewModel

  class DummyViewModel: ViewModelType {

    func transform(input: Input) -> Output {
      fatalError("transform(input:) has not been implemented")
    }

    struct Input {
    }

    struct Output {
    }

  }

}

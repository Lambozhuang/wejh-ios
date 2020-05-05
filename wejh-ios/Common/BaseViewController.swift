//
//  BaseViewController.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/1.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

class BaseViewController<ViewModel: ViewModelType>: UIViewController, NavigableControllerType {

  private(set) var navigator: Navigator!
  var viewModel: ViewModel?

  required init(viewModel: ViewModel, navigator: Navigator) {
    super.init(nibName: nil, bundle: nil)
    connect(viewModel: viewModel, navigator: navigator)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindToViewModel()
  }

  func connect(viewModel: ViewModel?, navigator: Navigator) {
    self.navigator = navigator
    connect(viewModel: viewModel)
  }

  func connect(viewModel: ViewModel?) {
    self.viewModel = viewModel
  }

  func setupUI() {

  }

  func bindToViewModel() {

  }

}

extension BaseViewController {

  func configureNavigationBarAppearance(enforceLargeTitle: Bool, backgroundColor: UIColor, tintColor: UIColor) {
    guard let navigationBar = navigationController?.navigationBar else {
      return
    }

    if enforceLargeTitle {
      navigationItem.largeTitleDisplayMode = .always
      navigationBar.prefersLargeTitles = true
    }

    navigationBar.tintColor = tintColor

    /// On iOS 13 or later, we should use `UINavigationBarAppearance` API
    /// Also, see: https://sarunw.com/posts/uinavigationbar-changes-in-ios13/
    if #available(iOS 13.0, *) {
      let navBarAppearance = UINavigationBarAppearance()

      navBarAppearance.configureWithOpaqueBackground()
      navBarAppearance.titleTextAttributes = [.foregroundColor: tintColor]
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
      navBarAppearance.backgroundColor = backgroundColor

      navigationBar.standardAppearance = navBarAppearance
      navigationBar.scrollEdgeAppearance = navBarAppearance
    } else {
      navigationBar.isTranslucent = false
      navigationBar.barTintColor = backgroundColor
      navigationBar.titleTextAttributes = [.foregroundColor: tintColor]
      navigationBar.largeTitleTextAttributes = [.foregroundColor: tintColor]
    }
  }

}

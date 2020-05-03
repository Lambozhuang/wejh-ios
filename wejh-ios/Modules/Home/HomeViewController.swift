//
//  HomeViewController.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/1.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit
import RxSwift
import RxViewController

class HomeViewController: BaseViewController<HomeViewModel>, StoryboardInstantiatable {

  static let storyboardIdentifier = "home"

  private var disposeBag = DisposeBag()

  override func setupUI() {
    self.view.backgroundColor = UIColor(.dm, light: .white, dark: .darkGray)
  }

  override func bindToViewModel() {
    guard let viewModel = viewModel else {
      return
    }
    let input = HomeViewModel.Input(whatsNewTrigger: rx.viewDidAppear.map( { _ in } ))
    let output = viewModel.transform(input: input)
    output.presentWhatsNew.drive(onNext: { [weak self] whatsNewTraits in
      guard let self = self, let traits = whatsNewTraits else {
        return
      }
      self.navigator.transition(to: .whatsNew(traits: traits), type: .modal, sender: self)
    }).disposed(by: disposeBag)
  }
  
}

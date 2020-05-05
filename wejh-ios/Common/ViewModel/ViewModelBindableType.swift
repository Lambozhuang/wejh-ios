//
//  ViewModelBindable.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/5.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

protocol ViewModelBindableType {

  associatedtype ViewModel: ViewModelType

  var viewModel: ViewModel? { get }

  func connect(viewModel: ViewModel?)

  func bindToViewModel()

}

//
//  ViewModelType.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/1.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

protocol ViewModelType {

}

protocol ComplexViewModelType: ViewModelType {

  associatedtype Input
  associatedtype Output

  func transform(input: Input) -> Output

}

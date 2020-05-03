//
//  Observable+Operators.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/3.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import RxSwift
import RxCocoa

extension ObservableType {

  func catchErrorJustComplete() -> Observable<Element> {
    return catchError { _ in
      return Observable.empty()
    }
  }

  func asDriverOnErrorJustComplete() -> Driver<Element> {
    return asDriver { error in
      assertionFailure("Error \(error)")
      return Driver.empty()
    }
  }

  func mapToVoid() -> Observable<Void> {
    return map { _ in
    }
  }

}

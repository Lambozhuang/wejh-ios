//
// Created by Bunny Wong on 2020/5/5.
// Copyright (c) 2020 Bunny Wong. All rights reserved.
//

import RxSwift
import RxRelay

final class HomeTodayCellCardViewModel: HomeTodayCellViewModel {

  let balance = BehaviorRelay<String?>(value: nil)

}

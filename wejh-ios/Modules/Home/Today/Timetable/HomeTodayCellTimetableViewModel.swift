//
// Created by Bunny Wong on 2020/5/5.
// Copyright (c) 2020 Bunny Wong. All rights reserved.
//

import RxSwift
import RxRelay

final class HomeTodayCellTimetableViewModel: HomeTodayCellViewModel {

  struct EventViewModel: ViewModelType {
    var eventName: String
    var eventTime: String
    var eventSchedule: String
    var eventLocation: String
  }

  let events = BehaviorRelay<[EventViewModel]>(value: [])

  init(events: [EventViewModel]) {
    self.events.accept(events)
  }

}

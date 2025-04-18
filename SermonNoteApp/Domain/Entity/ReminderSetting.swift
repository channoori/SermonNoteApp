//
//  ReminderSetting.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import Foundation
import SwiftDate

struct ReminderSetting: Identifiable, Equatable {
    let id: String
    let applicationText: String
    let weekdays: Set<WeekDay>
    let hour: Int
    let minute: Int

    init(
        id: String = UUID().uuidString,
        applicationText: String,
        weekdays: Set<WeekDay>,
        hour: Int,
        minute: Int
    ) {
        self.id = id
        self.applicationText = applicationText
        self.weekdays = weekdays
        self.hour = hour
        self.minute = minute
    }
}

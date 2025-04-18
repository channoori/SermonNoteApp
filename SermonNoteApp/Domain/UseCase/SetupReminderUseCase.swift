//
//  SetupReminderUseCase.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import Foundation
import Combine
import SwiftDate

final class SetupReminderUseCase {

    private let notificationManager: ReminderNotificationManager

    init(notificationManager: ReminderNotificationManager) {
        self.notificationManager = notificationManager
    }

    func execute(
        applicationText: String,
        weekdays: Set<WeekDay>,
        hour: Int,
        minute: Int
    ) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            self.notificationManager.requestAuthorization { granted in
                if !granted {
                    promise(.failure(ReminderError.permissionDenied))
                    return
                }

                for day in weekdays {
                    self.notificationManager.scheduleReminder(
                        title: "오늘의 적용",
                        body: applicationText,
                        weekday: day,
                        hour: hour,
                        minute: minute
                    )
                }

                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }

    enum ReminderError: Error {
        case permissionDenied
    }
}

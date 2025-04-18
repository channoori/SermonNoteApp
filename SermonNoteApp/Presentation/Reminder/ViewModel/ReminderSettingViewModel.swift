//
//  ReminderSettingViewModel.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import Foundation
import Combine
import SwiftDate

final class ReminderSettingViewModel {

    // MARK: - Inputs
    @Published var selectedHour: Int = 8
    @Published var selectedMinute: Int = 0
    @Published var selectedWeekdays: Set<WeekDay> = [.monday]
    @Published var applicationText: String = ""

    // MARK: - Outputs
    @Published private(set) var reminderSaved: Bool = false
    @Published private(set) var errorMessage: String?

    // MARK: - Dependencies
    private let notificationManager: ReminderNotificationManager
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(notificationManager: ReminderNotificationManager = .shared) {
        self.notificationManager = notificationManager
    }

    // MARK: - Actions
    func requestPermissionAndSchedule() {
        notificationManager.requestAuthorization { [weak self] granted in
            guard let self = self else { return }

            if granted {
                self.scheduleReminders()
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "알림 권한이 필요합니다."
                }
            }
        }
    }

    private func scheduleReminders() {
        for day in selectedWeekdays {
            notificationManager.scheduleReminder(
                title: "오늘의 적용",
                body: applicationText.isEmpty ? "이번 주의 말씀을 기억하세요." : applicationText,
                weekday: day,
                hour: selectedHour,
                minute: selectedMinute
            )
        }

        DispatchQueue.main.async {
            self.reminderSaved = true
        }
    }
}


//
//  ReminderNotificationManager.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import Foundation
import UserNotifications
import SwiftDate

final class ReminderNotificationManager {
    static let shared = ReminderNotificationManager()
    
    private let center = UNUserNotificationCenter.current()
    
    func requestAuthorization(completion: @escaping(Bool) -> Void) {
        center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    // MARK: - 알림 등록
    func scheduleReminder(
        id: String = UUID().uuidString,
        title: String,
        body: String,
        weekday: WeekDay,  // SwiftDate의 WeekDay (월~일: 2~1)
        hour: Int,
        minute: Int
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.weekday = weekday.rawValue
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        center.add(request) { error in
            if let error = error {
                print("❌ 알림 등록 실패: \(error.localizedDescription)")
            } else {
                print("✅ 알림 등록 완료: \(id)")
            }
        }
    }

    // MARK: - 모든 알림 삭제
    func clearAllReminders() {
        center.removeAllPendingNotificationRequests()
        print("🧹 모든 알림 삭제 완료")
    }

    // MARK: - 특정 알림 삭제
    func removeReminder(id: String) {
        center.removePendingNotificationRequests(withIdentifiers: [id])
        print("🗑️ 알림 삭제됨: \(id)")
    }

    // MARK: - 현재 등록된 알림 확인 (디버깅용)
    func printScheduledReminders() {
        center.getPendingNotificationRequests { requests in
            print("📋 현재 등록된 알림 수: \(requests.count)")
            requests.forEach {
                print("🔔 \($0.identifier): \($0.content.body)")
            }
        }
    }
}

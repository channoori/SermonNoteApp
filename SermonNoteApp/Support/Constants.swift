//
//  Constants.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import UIKit

enum Constants {

    enum Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }

    enum CornerRadius {
        static let small: CGFloat = 6
        static let medium: CGFloat = 12
        static let full: CGFloat = 999 // 원형 처리용
    }

    enum Font {
        static let title = UIFont.systemFont(ofSize: 20, weight: .bold)
        static let subtitle = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let body = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let caption = UIFont.systemFont(ofSize: 12, weight: .light)
    }

    enum Color {
        static let primary = UIColor.systemBlue
        static let secondary = UIColor.systemGray
        static let background = UIColor.systemGroupedBackground
        static let text = UIColor.label
        static let highlight = UIColor.systemYellow
        static let error = UIColor.systemRed
    }

    enum Animation {
        static let durationShort: TimeInterval = 0.2
        static let durationMedium: TimeInterval = 0.4
        static let durationLong: TimeInterval = 0.6
    }

    enum Icon {
        static let add = UIImage(systemName: "plus")
        static let bell = UIImage(systemName: "bell")
        static let checkmark = UIImage(systemName: "checkmark.circle.fill")
        static let warning = UIImage(systemName: "exclamationmark.triangle")
    }

    enum UserDefaultsKey {
        static let firstLaunchDone = "firstLaunchDone"
        static let lastReminderDate = "lastReminderDate"
    }

    enum Strings {
        static let appTitle = "한절한절"
        static let defaultReminderText = "이번 주 받은 말씀을 기억하세요."
    }
}

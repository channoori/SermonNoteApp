//
//  WeekDay+UI.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import SwiftDate

extension WeekDay {
    var shortName: String {
        switch self {
        case .monday: return "월"
        case .tuesday: return "화"
        case .wednesday: return "수"
        case .thursday: return "목"
        case .friday: return "금"
        case .saturday: return "토"
        case .sunday: return "일"
        }
    }

    static var allCases: [WeekDay] {
        return [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    }
}

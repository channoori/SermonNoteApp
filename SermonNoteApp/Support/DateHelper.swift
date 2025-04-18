//
//  DateHelper.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import Foundation
import SwiftDate

enum DateHelper {

    /// Date → "yyyy.MM.dd" 포맷 문자열
    static func formatDate(_ date: Date, format: String = "yyyy.MM.dd") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    /// Date → "요일 (월/화/수...)" 반환
    static func weekdayString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }

    /// Date → 시간 문자열 ("오전 08:30" 형태)
    static func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a hh:mm"
        return formatter.string(from: date)
    }

    /// 현재 시각 기준으로 오늘인지 여부
    static func isToday(_ date: Date) -> Bool {
        return Calendar.current.isDateInToday(date)
    }

    /// 현재 시각 기준으로 어제인지 여부
    static func isYesterday(_ date: Date) -> Bool {
        return Calendar.current.isDateInYesterday(date)
    }

    /// 특정 시간(hour, minute)을 기반으로 Date 생성 (오늘 기준)
    static func dateForTime(hour: Int, minute: Int) -> Date? {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components)
    }

    /// 특정 요일을 나타내는 문자열 → WeekDay enum
    static func weekDayFromKoreanString(_ day: String) -> WeekDay? {
        switch day {
        case "월": return .monday
        case "화": return .tuesday
        case "수": return .wednesday
        case "목": return .thursday
        case "금": return .friday
        case "토": return .saturday
        case "일": return .sunday
        default: return nil
        }
    }
}

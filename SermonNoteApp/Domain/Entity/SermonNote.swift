//
//  SermonNote.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import Foundation

struct SermonNote: Identifiable, Equatable {
    let id: String
    let title: String
    let date: Date
    let scripture: String
    let summary: String
    let application: String

    init(
        id: String = UUID().uuidString,
        title: String,
        date: Date,
        scripture: String,
        summary: String,
        application: String
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.scripture = scripture
        self.summary = summary
        self.application = application
    }
}

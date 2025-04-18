//
//  SermonNoteObject.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import Foundation
import RealmSwift

final class SermonNoteObject: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var date: Date
    @Persisted var scripture: String
    @Persisted var summary: String
    @Persisted var application: String

    convenience init(from entity: SermonNote) {
        self.init()
        self.id = entity.id
        self.title = entity.title
        self.date = entity.date
        self.scripture = entity.scripture
        self.summary = entity.summary
        self.application = entity.application
    }
    
    func toEntity() -> SermonNote {
        return SermonNote(id: self.id, title: self.title, date: self.date, scripture: self.scripture, summary: self.summary, application: self.application)
    }
}

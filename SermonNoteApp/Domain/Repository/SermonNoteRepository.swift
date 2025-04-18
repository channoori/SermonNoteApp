//
//  SermonNoteRepository.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import Foundation
import Combine

protocol SermonNoteRepository {
    func save(note: SermonNote) -> AnyPublisher<Void, Error>
    func fetchAllNotes() -> AnyPublisher<[SermonNote], Error>
}

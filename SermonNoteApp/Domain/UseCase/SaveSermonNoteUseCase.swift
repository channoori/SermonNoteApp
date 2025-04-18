//
//  SaveSermonNoteUseCase.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import Foundation
import Combine

final class SaveSermonNoteUseCase {

    private let repository: SermonNoteRepository

    init(repository: SermonNoteRepository) {
        self.repository = repository
    }

    func execute(note: SermonNote) -> AnyPublisher<Void, Error> {
        return repository.save(note: note)
    }
}

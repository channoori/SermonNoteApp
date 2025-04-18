//
//  GetSermonNoteUseCase.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import Combine

final class GetSermonNoteUseCase {
    private let repository: SermonNoteRepository
    
    init(repository: SermonNoteRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[SermonNote], Error> {
        return repository.fetchAllNotes()
    }
}

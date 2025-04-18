//
//  SermonNoteViewModel.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import Foundation
import Combine

final class SermonNoteViewModel {

    // MARK: - Published Outputs

    @Published private(set) var notes: [SermonNote] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Dependencies

    private let saveUseCase: SaveSermonNoteUseCase
    private let getUseCase: GetSermonNoteUseCase
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    init(
        saveUseCase: SaveSermonNoteUseCase,
        getUseCase: GetSermonNoteUseCase
    ) {
        self.saveUseCase = saveUseCase
        self.getUseCase = getUseCase
    }

    // MARK: - Actions

    func loadNotes() {
        isLoading = true
        getUseCase.execute()
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] notes in
                self?.notes = notes
            }
            .store(in: &cancellables)
    }

    func saveNote(note: SermonNote) {
        saveUseCase.execute(note: note)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] in
                self?.loadNotes() // 저장 후 최신 목록 다시 불러오기
            }
            .store(in: &cancellables)
    }
}

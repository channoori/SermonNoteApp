//
//  AppDIContainer.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import Foundation

final class AppDIContainer {
    // MARK: - Repository
    lazy var sermonNoteRepository: SermonNoteRepository = {
        SermonNoteRepositoryImpl()
    }()
    
    // MARK: - UseCases
    func makeSaveSermonNoteUseCase() -> SaveSermonNoteUseCase {
        return SaveSermonNoteUseCase(repository: sermonNoteRepository)
    }

    func makeGetSermonNotesUseCase() -> GetSermonNoteUseCase {
        return GetSermonNoteUseCase(repository: sermonNoteRepository)
    }

    func makeReminderUseCase() -> SetupReminderUseCase {
        return SetupReminderUseCase(notificationManager: ReminderNotificationManager())
    }

    // MARK: - Reminder DI
    func makeReminderNotificationManager() -> ReminderNotificationManager {
        return ReminderNotificationManager.shared
    }
    
    func makeReminderSettingViewModel(preFilledText: String? = nil) -> ReminderSettingViewModel {
        let vm = ReminderSettingViewModel(notificationManager: makeReminderNotificationManager())
        if let text = preFilledText {
            vm.applicationText = text
        }
        return vm
    }

    // MARK: - ViewModels
    func makeSermonNoteViewModel() -> SermonNoteViewModel {
        return SermonNoteViewModel(saveUseCase: makeSaveSermonNoteUseCase(), getUseCase: makeGetSermonNotesUseCase())
    }
}

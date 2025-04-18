//
//  SermonNoteRepositoryImpl.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import Foundation
import RealmSwift
import Combine

final class SermonNoteRepositoryImpl: SermonNoteRepository {

    private let realmQueue = DispatchQueue(label: "realm.background.queue")

    // MARK: - 저장
    func save(note: SermonNote) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            self.realmQueue.async {
                do {
                    let realm = try Realm()
                    let object = SermonNoteObject(from: note)

                    try realm.write {
                        realm.add(object, update: .modified)
                    }

                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    // MARK: - 전체 불러오기
    func fetchAllNotes() -> AnyPublisher<[SermonNote], Error> {
        return Future<[SermonNote], Error> { promise in
            self.realmQueue.async {
                do {
                    let realm = try Realm()
                    let objects = realm.objects(SermonNoteObject.self)
                        .sorted(byKeyPath: "date", ascending: false)
                    let notes = objects.map { $0.toEntity() }

                    promise(.success(Array(notes)))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}


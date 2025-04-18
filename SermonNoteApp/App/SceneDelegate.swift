//
//  SceneDelegate.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let diContainer = AppDIContainer()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        print("Realm DB file path: \(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
        
        let viewModel = diContainer.makeSermonNoteViewModel()
        
        let rootViewController = SermonNoteViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}


//
//  HeroTransitionManager.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import UIKit
import Hero

final class HeroTransitionManager {

    static func configureNavigation(_ navigationController: UINavigationController) {
        navigationController.hero.isEnabled = true
        navigationController.heroNavigationAnimationType = .autoReverse(presenting: .fade)
    }

    static func applyFadeTransition(to viewController: UIViewController) {
        viewController.hero.isEnabled = true
        viewController.heroModalAnimationType = .fade
    }

    static func applyPushSlideTransition(to viewController: UIViewController) {
        viewController.hero.isEnabled = true
        viewController.heroModalAnimationType = .push(direction: .left)
    }

    static func applyCoverVerticalTransition(to viewController: UIViewController) {
        viewController.hero.isEnabled = true
        viewController.heroModalAnimationType = .cover(direction: .up)
    }

    static func applyZoomTransition(to viewController: UIViewController) {
        viewController.hero.isEnabled = true
        viewController.heroModalAnimationType = .zoom
    }

    // 커스텀 요소에 heroID를 적용하는 유틸 함수
    static func setHeroID(_ view: UIView, id: String) {
        view.heroID = id
        view.isUserInteractionEnabled = true
    }
}

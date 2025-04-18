//
//  UIView+Layout.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import UIKit

extension UIView {

    /// 여러 서브뷰를 한 번에 추가
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }

    /// 둥글게 만들기
    func makeRounded(cornerRadius: CGFloat? = nil) {
        self.layer.cornerRadius = cornerRadius ?? (self.frame.height / 2)
        self.layer.masksToBounds = true
    }

    /// 그림자 효과 추가
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.1,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 8
    ) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = alpha
        self.layer.shadowOffset = CGSize(width: x, height: y)
        self.layer.shadowRadius = blur / 2.0
        self.layer.masksToBounds = false
    }

    /// 테두리 설정
    func setBorder(color: UIColor, width: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }

    /// 인터랙션 강조 애니메이션
    func popAnimation(scale: CGFloat = 1.05, duration: TimeInterval = 0.1) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { _ in
            UIView.animate(withDuration: duration) {
                self.transform = .identity
            }
        }
    }

    /// 디버깅용 테두리 표시
    func debugBorder(_ color: UIColor = .red) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
    }
}

//
//  SermonNoteDetailViewController.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import UIKit
import SnapKit

final class SermonNoteDetailViewController: UIViewController {

    // MARK: - Properties

    private let note: SermonNote
    private let applyLabel = UILabel()
    private let scriptureLabel = UILabel()
    private let summaryLabel = UILabel()
    private let dateLabel = UILabel()
    private let setReminderButton = UIButton(type: .system)

    private let diContainer = AppDIContainer() // 의존성 주입용

    // MARK: - Init

    init(note: SermonNote) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = note.title

        // 날짜
        dateLabel.text = "📅 \(formattedDate(note.date))"
        dateLabel.font = .systemFont(ofSize: 14, weight: .light)
        view.addSubview(dateLabel)

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        // 성경 구절
        scriptureLabel.text = "📖 말씀: \(note.scripture)"
        scriptureLabel.numberOfLines = 0
        scriptureLabel.font = .systemFont(ofSize: 16)
        view.addSubview(scriptureLabel)

        scriptureLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        // 요약
        summaryLabel.text = "📝 요약: \(note.summary)"
        summaryLabel.numberOfLines = 0
        summaryLabel.font = .systemFont(ofSize: 16)
        view.addSubview(summaryLabel)

        summaryLabel.snp.makeConstraints {
            $0.top.equalTo(scriptureLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        // 적용 문구
        applyLabel.text = "✅ 적용: \(note.application)"
        applyLabel.numberOfLines = 0
        applyLabel.font = .systemFont(ofSize: 16)
        applyLabel.textColor = .systemBlue
        view.addSubview(applyLabel)

        applyLabel.snp.makeConstraints {
            $0.top.equalTo(summaryLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        // 리마인더 설정 버튼
        setReminderButton.setTitle("리마인더 설정하기", for: .normal)
        setReminderButton.setTitleColor(.white, for: .normal)
        setReminderButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        setReminderButton.backgroundColor = .systemBlue
        setReminderButton.layer.cornerRadius = 8
        setReminderButton.addTarget(self, action: #selector(reminderTapped), for: .touchUpInside)
        view.addSubview(setReminderButton)

        setReminderButton.snp.makeConstraints {
            $0.top.equalTo(applyLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
    }

    // MARK: - Actions

    @objc private func reminderTapped() {
        let viewModel = diContainer.makeReminderSettingViewModel(preFilledText: note.application)
        let vc = ReminderSettingViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Utils

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

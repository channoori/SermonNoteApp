//
//  ReminderSettingViewController.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import UIKit
import SnapKit
import Combine
import SwiftDate

final class ReminderSettingViewController: UIViewController {

    // MARK: - UI
    private let applicationTextView = UITextView()
    private let timePicker = UIDatePicker()
    private let weekdayButtons: [UIButton] = WeekDay.allCases.map { day in
        let button = UIButton(type: .system)
        button.setTitle(day.shortName, for: .normal)
        button.tag = day.rawValue
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        return button
    }
    private let saveButton = UIButton(type: .system)

    // MARK: - ViewModel
    private let viewModel: ReminderSettingViewModel
    private var cancellables = Set<AnyCancellable>()
    private var selectedDays = Set<WeekDay>()

    // MARK: - Init
    init(viewModel: ReminderSettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    // MARK: - UI 구성
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "리마인더 설정"

        // 적용 문구
        applicationTextView.layer.borderColor = UIColor.systemGray5.cgColor
        applicationTextView.layer.borderWidth = 1
        applicationTextView.layer.cornerRadius = 8
        applicationTextView.font = .systemFont(ofSize: 16)
        view.addSubview(applicationTextView)

        applicationTextView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(100)
        }

        // 시간 선택
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        view.addSubview(timePicker)

        timePicker.snp.makeConstraints {
            $0.top.equalTo(applicationTextView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        // 요일 선택
        let weekdayStack = UIStackView(arrangedSubviews: weekdayButtons)
        weekdayStack.axis = .horizontal
        weekdayStack.spacing = 8
        weekdayStack.distribution = .fillEqually
        view.addSubview(weekdayStack)

        weekdayStack.snp.makeConstraints {
            $0.top.equalTo(timePicker.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }

        weekdayButtons.forEach { button in
            button.addTarget(self, action: #selector(weekdayTapped(_:)), for: .touchUpInside)
        }

        // 저장 버튼
        saveButton.setTitle("저장하기", for: .normal)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 8
        view.addSubview(saveButton)

        saveButton.snp.makeConstraints {
            $0.top.equalTo(weekdayStack.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }

        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    // MARK: - ViewModel 바인딩
    private func bindViewModel() {
        viewModel.$reminderSaved
            .receive(on: RunLoop.main)
            .filter { $0 }
            .sink { [weak self] _ in
                self?.showSavedAlert()
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { [weak self] message in
                self?.showErrorAlert(message)
            }
            .store(in: &cancellables)
    }

    // MARK: - Actions

    @objc private func weekdayTapped(_ sender: UIButton) {
        guard let day = WeekDay(rawValue: sender.tag) else { return }
        if selectedDays.contains(day) {
            selectedDays.remove(day)
            sender.backgroundColor = .clear
        } else {
            selectedDays.insert(day)
            sender.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        }
    }

    @objc private func saveButtonTapped() {
        let calendar = Calendar.current
        let date = timePicker.date
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)

        viewModel.selectedHour = hour
        viewModel.selectedMinute = minute
        viewModel.selectedWeekdays = selectedDays
        viewModel.applicationText = applicationTextView.text

        viewModel.requestPermissionAndSchedule()
    }

    private func showSavedAlert() {
        let alert = UIAlertController(title: "✅ 설정 완료", message: "리마인더가 저장되었습니다!", preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default))
        present(alert, animated: true)
    }

    private func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "⚠️ 오류", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

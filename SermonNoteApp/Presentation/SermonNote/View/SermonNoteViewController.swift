//
//  SermonNoteViewController.swift
//  SermonNoteApp
//
//  Created by 박찬누리 on 4/18/25.
//

import UIKit
import SnapKit
import Combine

final class SermonNoteViewController: UIViewController {

    // MARK: - UI Components

    private let tableView = UITableView()
    private let addButton = UIButton(type: .system)

    // MARK: - ViewModel

    private let viewModel: SermonNoteViewModel
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: SermonNoteViewModel) {
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
        viewModel.loadNotes()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "설교 노트"

        // TableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NoteCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        // Add Button
        addButton.setTitle("➕ 노트 추가", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        addButton.layer.cornerRadius = 24
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        view.addSubview(addButton)

        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.width.height.equalTo(48)
        }
    }

    // MARK: - Binding

    private func bindViewModel() {
        viewModel.$notes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.showErrorAlert(message)
            }
            .store(in: &cancellables)
    }

    // MARK: - Actions

    @objc private func addButtonTapped() {
        let now = Date()
        let note = SermonNote(
            title: "새 설교 노트 \(now.formatted(date: .numeric, time: .omitted))",
            date: now,
            scripture: "시편 119:105",
            summary: "주의 말씀은 내 발에 등이요",
            application: "오늘 말씀을 마음에 새기자"
        )
        viewModel.saveNote(note: note)
    }

    private func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "⚠️ 오류", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension SermonNoteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = viewModel.notes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = "📖 \(note.title)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SermonNoteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = viewModel.notes[indexPath.row]
        let detailVC = SermonNoteDetailViewController(note: note)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

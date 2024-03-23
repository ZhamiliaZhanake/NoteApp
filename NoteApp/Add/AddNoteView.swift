//
//  AddNoteView.swift
//  NoteApp
//
//  Created by Zhamilia Zhanakeeva on 23/3/24.
//

import UIKit
class AddNoteView: UIViewController {
    private let coreDataService = CoreDataService.shared
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.layer.borderWidth = 1
        return view
    }()
    private lazy var saveButton: UIButton = {
        let view = UIButton()
        view.setTitle("Save", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 20
        view.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpConstraints()
    }
    @objc func saveButtonTapped() {
        let id = UUID().uuidString
        let date = Date()
        coreDataService.addNotes(id: id, title: titleTextField.text ?? "", description: "some", date: date)
    }
    private func setUpConstraints() {
        view.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

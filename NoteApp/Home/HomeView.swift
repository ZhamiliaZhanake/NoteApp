//
//  ViewController.swift
//  NoteApp
//
//  Created by Zhamilia Zhanakeeva on 14/3/24.
//

import UIKit
protocol HomeViewProtocol {
    func successNotes(notes: [Notes])
}
class HomeView: UIViewController {
    private var controller: HomeControllerProtocol?
    private var notes: [Notes] = []
    
    private lazy var noteSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search"
        view.backgroundImage = UIImage()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Notes"
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }()
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(NoteCell.self, forCellWithReuseIdentifier: NoteCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .red
        view.setTitle("+", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        view.layer.cornerRadius = 42 / 2
        view.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        controller = HomeController(view: self)
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        let isDarkTheme = UserDefaults.standard.bool(forKey: "isDarkTheme")
        if isDarkTheme == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
        setupNavigationItem(isDarkTheme: isDarkTheme)
        controller?.onGetNotes()
    }
    
    private func setupNavigationItem(isDarkTheme: Bool) {
        navigationItem.title = "Main"
        let settingsBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingIcon"), style: .plain, target: self, action: #selector(settingButtonTapped))
        navigationItem.rightBarButtonItem = settingsBarButtonItem
        if isDarkTheme == true {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationItem.rightBarButtonItem?.tintColor = .white
        } else {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationItem.rightBarButtonItem?.tintColor = .black
        }
    }
    
    @objc func settingButtonTapped() {
        let vc = SettingsView()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func addButtonTapped() {
        let vc = AddNoteView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupConstraints() {
        view.addSubview(noteSearchBar)
        noteSearchBar.translatesAutoresizingMaskIntoConstraints = false
        noteSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        noteSearchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        noteSearchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        noteSearchBar.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: noteSearchBar.bottomAnchor, constant: 32).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 49).isActive = true
        
        view.addSubview(notesCollectionView)
        notesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        notesCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40).isActive = true
        notesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        notesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        notesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 42).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
    }
}
extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCell.reuseId, for: indexPath) as! NoteCell
        cell.setup(title: notes[indexPath.row].title ?? "")
        return cell
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 60) / 2, height: 100)
    }
}

extension HomeView: HomeViewProtocol {
    func successNotes(notes: [Notes]) {
        self.notes = notes
        notesCollectionView.reloadData()
    }
}

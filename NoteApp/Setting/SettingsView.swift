//
//  SettingsView.swift
//  NoteApp
//
//  Created by Zhamilia Zhanakeeva on 16/3/24.
//

import UIKit
protocol SettingsViewProtocol: AnyObject {
}

class SettingsView: UIViewController {
    var controller: SettingsControllerProtocol?
    
    private var settings: [Settings] = [
        Settings(image: UIImage(named: "languageIcon"), title: "Language", description: "English", type: .withRightButton),
        Settings(image: UIImage(named: "moon"), title: "Dark Mode", description: "", type: .withSwitch),
        Settings(image: UIImage(named: "trash"), title: "Clear Data", description: "", type: .usual)]
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseId)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = SettingsController(settingsView: self)
        view.backgroundColor = .systemBackground
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isDarkTheme = UserDefaults.standard.bool(forKey: "isDarkTheme")
        if isDarkTheme == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
        setupNavigationItem(isDarkTheme: isDarkTheme)
    }
    
    private func setupNavigationItem(isDarkTheme: Bool) {
        navigationItem.title = "Settings"
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
    
    private func setupConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    deinit {}
    
    @objc func settingButtonTapped() {
        
    }
}

extension SettingsView: SettingsViewProtocol {
}

extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseId, for: indexPath) as! SettingsCell
        cell.delegate = self
        cell.setup(settings: settings[indexPath.row])
        return cell
    }
}

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
}

extension SettingsView: SettingsCellDelegate {
    func didSwitchOn(isOn: Bool) {
        UserDefaults.standard.setValue(isOn, forKey: "isDarkTheme")
        if isOn == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
}


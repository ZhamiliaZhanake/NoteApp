//
//  SettingsController.swift
//  NoteApp
//
//  Created by Zhamilia Zhanakeeva on 18/3/24.
//

import Foundation
protocol SettingsControllerProtocol: AnyObject {
}

class SettingsController: SettingsControllerProtocol {
    weak var settingsView: SettingsViewProtocol!
    var model: SettingsModel?
    init(settingsView: SettingsViewProtocol) {
        self.settingsView = settingsView
        self.model = SettingsModel(controller: self)
    }
    deinit {}
}

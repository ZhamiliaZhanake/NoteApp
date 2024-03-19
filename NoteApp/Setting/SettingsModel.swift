//
//  SettingModel.swift
//  NoteApp
//
//  Created by Zhamilia Zhanakeeva on 18/3/24.
//

import Foundation
protocol SettingsModelProtocol: AnyObject {
}

class SettingsModel: SettingsModelProtocol {
    weak var controller: SettingsControllerProtocol?
    init(controller: SettingsControllerProtocol) {
        self.controller = controller
    }
    deinit {}
}

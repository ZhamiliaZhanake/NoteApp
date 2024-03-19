//
//  HomeModel.swift
//  NoteApp
//
//  Created by Zhamilia Zhanakeeva on 14/3/24.
//

import Foundation
protocol HomeModelProtocol {
    func getNotes()
}
class HomeModel: HomeModelProtocol {
    var controller: HomeControllerProtocol?
    var notes: [String] = ["School notes", "Travel bucket list", "Products", "Stories"]
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    func getNotes() {
        controller?.onSuccessNotes(notes: notes)
    }
}

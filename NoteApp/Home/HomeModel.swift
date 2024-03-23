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
    private let coreDataService = CoreDataService.shared
    var notes: [Notes] = []
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    func getNotes() {
        notes = coreDataService.fetchNotes()
        controller?.onSuccessNotes(notes: notes)
    }
}

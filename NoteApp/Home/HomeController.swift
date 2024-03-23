//
//  HomeController.swift
//  NoteApp
//
//  Created by Zhamilia Zhanakeeva on 14/3/24.
//

import Foundation
protocol HomeControllerProtocol {
    func onGetNotes()
    func onSuccessNotes(notes: [Notes])
}

class HomeController: HomeControllerProtocol {
    private var model: HomeModel?
    private var view: HomeViewProtocol?
    init(view: HomeViewProtocol) {
        self.model = HomeModel(controller: self)
        self.view = view
    }
    func onGetNotes() {
        model?.getNotes()
    }
    func onSuccessNotes(notes: [Notes]){
        view?.successNotes(notes: notes)
    }
}

//
//  CoreDataService.swift
//  NoteApp
//
//  Created by Zhamilia Zhanakeeva on 23/3/24.
//

import Foundation
import UIKit
import CoreData
class CoreDataService: NSObject {
    static let shared = CoreDataService()
    
    private override init() {
        
    }
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func addNotes(id: String, title: String, description: String, date: Date) {
        guard let noteEntity = NSEntityDescription.entity(forEntityName: "Notes", in: context) else {
            return
        }
        let note = Notes(entity: noteEntity, insertInto: context)
        note.id = id
        note.title = title
        note.desc = description
        note.date = date
        appDelegate.saveContext()
    }
    //READ
    func fetchNotes() -> [Notes] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        do {
            return try context.fetch(fetchRequest) as! [Notes]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}

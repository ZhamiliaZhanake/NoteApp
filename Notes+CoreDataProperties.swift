//
//  Notes+CoreDataProperties.swift
//  NoteApp
//
//  Created by Zhamilia Zhanakeeva on 23/3/24.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var date: Date?

}

extension Notes : Identifiable {

}

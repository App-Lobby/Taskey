//
//  Reminder+CoreDataProperties.swift
//  Taskey
//
//  Created by Mohammad Yasir on 24/05/21.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var title: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var createdAt: Date?
    @NSManaged public var app: App?

}

extension Reminder : Identifiable {

}

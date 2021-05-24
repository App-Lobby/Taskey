//
//  App+CoreDataProperties.swift
//  Taskey
//
//  Created by Mohammad Yasir on 24/05/21.
//
//

import Foundation
import CoreData


extension App {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<App> {
        return NSFetchRequest<App>(entityName: "App")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var profilePhoto: Data?
    @NSManaged public var createdAt: Date
    @NSManaged public var reminder: NSSet?

}

// MARK: Generated accessors for reminder
extension App {

    @objc(addReminderObject:)
    @NSManaged public func addToReminder(_ value: Reminder)

    @objc(removeReminderObject:)
    @NSManaged public func removeFromReminder(_ value: Reminder)

    @objc(addReminder:)
    @NSManaged public func addToReminder(_ values: NSSet)

    @objc(removeReminder:)
    @NSManaged public func removeFromReminder(_ values: NSSet)

}

extension App : Identifiable {

}

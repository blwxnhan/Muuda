//
//  Diary+CoreDataProperties.swift
//  Muda
//
//  Created by Bowon Han on 8/1/24.
//
//

import Foundation
import CoreData


extension Diary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Diary> {
        return NSFetchRequest<Diary>(entityName: "Diary")
    }

    @NSManaged public var title: String?
    @NSManaged public var singer: String?
    @NSManaged public var imageName: String?
    @NSManaged public var diary: String?
    @NSManaged public var color: String?
    @NSManaged public var date: Date?
    @NSManaged public var isLike: Bool
    @NSManaged public var id: UUID?

}

extension Diary : Identifiable {

}

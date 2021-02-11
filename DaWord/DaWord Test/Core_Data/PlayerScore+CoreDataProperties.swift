//
//  PlayerScore+CoreDataProperties.swift
//  DaWord Test
//
//  Created by Ahmad Adnan Abdullah on 2020-12-07.
//
//

import Foundation
import CoreData


extension PlayerScore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerScore> {
        return NSFetchRequest<PlayerScore>(entityName: "PlayerScore")
    }

    @NSManaged public var score: Int32
    @NSManaged public var name: String?
    @NSManaged public var location: String?

}

extension PlayerScore : Identifiable {

}

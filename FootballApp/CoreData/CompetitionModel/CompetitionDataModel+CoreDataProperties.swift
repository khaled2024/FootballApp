//
//  CompetitionDataModel+CoreDataProperties.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 20/11/2024.
//
//

import Foundation
import CoreData


extension CompetitionDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompetitionDataModel> {
        return NSFetchRequest<CompetitionDataModel>(entityName: "CompetitionDataModel")
    }

    @NSManaged public var code: String?
    @NSManaged public var currentMatch: Int64
    @NSManaged public var name: String?
    @NSManaged public var numSeasons: Int64
    @NSManaged public var image: String?

}

extension CompetitionDataModel : Identifiable {

}

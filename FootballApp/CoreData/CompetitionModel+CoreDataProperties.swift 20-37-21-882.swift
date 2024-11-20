//
//  CompetitionModel+CoreDataProperties.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 20/11/2024.
//
//

import Foundation
import CoreData


extension CompetitionModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompetitionModel> {
        return NSFetchRequest<CompetitionModel>(entityName: "CompetitionModel")
    }

    @NSManaged public var name: String?
    @NSManaged public var code: String?
    @NSManaged public var numSeasons: Int64
    @NSManaged public var currentMatch: Int64

}

extension CompetitionModel : Identifiable {

}

//
//  MatchDataModel+CoreDataProperties.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 20/11/2024.
//
//

import Foundation
import CoreData


extension MatchDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MatchDataModel> {
        return NSFetchRequest<MatchDataModel>(entityName: "MatchDataModel")
    }

    @NSManaged public var awayCode: String?
    @NSManaged public var awayImage: String?
    @NSManaged public var awayName: String?
    @NSManaged public var homeCode: String?
    @NSManaged public var homeImage: String?
    @NSManaged public var homeName: String?
    @NSManaged public var status: String?
    @NSManaged public var homeResult: String?
    @NSManaged public var awayResult: String?

}

extension MatchDataModel : Identifiable {

}

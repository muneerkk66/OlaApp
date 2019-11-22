//
//  Taxi+CoreDataProperties.swift
//  OlaApp
//
//  Created by Muneer KK on 22/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//
//

import Foundation
import CoreData


extension Taxi {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Taxi> {
        return NSFetchRequest<Taxi>(entityName: "Taxi")
    }

    @NSManaged public var uniqueID: String?
    @NSManaged public var modelID: String?
    @NSManaged public var modelName: String?
    @NSManaged public var group: String?
    @NSManaged public var vehicleNumber: String?
    @NSManaged public var status: String?
    @NSManaged public var imgUrl: String?
    @NSManaged public var taxiDetails: TaxiDetails?
    @NSManaged public var location: Location?

}

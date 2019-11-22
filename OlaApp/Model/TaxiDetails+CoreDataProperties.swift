//
//  TaxiDetails+CoreDataProperties.swift
//  OlaApp
//
//  Created by Muneer KK on 22/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//
//

import Foundation
import CoreData


extension TaxiDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaxiDetails> {
        return NSFetchRequest<TaxiDetails>(entityName: "TaxiDetails")
    }

    @NSManaged public var name: String?
    @NSManaged public var make: String?
    @NSManaged public var color: String?
    @NSManaged public var series: String?
    @NSManaged public var fuelType: String?
    @NSManaged public var fuelLevel: Double
    @NSManaged public var transmission: String?
    @NSManaged public var taxi: Taxi?

}

//
//  Taxi.swift
//  OlaApp
//
//  Created by Muneer KK on 22/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//
import UIKit
import Foundation
struct TaxiResponse:Codable {
    var uniqueID:String
    var modelID:String
    var modelName:String
    var group:String
    var vehicleNumber:String
    var status:String
    var imgUrl:String
    var taxiDetails:TaxiDetailsResponse
    var location: LocationResponse

    //MARK: Codingkey Swift will automatically use this as the key type. This therefore allows you to easily customise the keys that your properties are encoded/decoded with.
    enum CodingKeys: String, CodingKey {
         case uniqueID      = "id"
         case modelID       = "modelIdentifier"
         case modelName     = "modelName"
         case group         = "group"
         case vehicleNumber = "licensePlate"
         case status        = "innerCleanliness"
         case imgUrl        = "carImageUrl"
         case taxiDetails   = "vehicleDetails"
         case location      = "location"
    }
}
struct TaxiDetailsResponse:Codable {
    var name:String
    var make:String
    var color:String
    var series:String
    var fuelType:String
    var fuelLevel:Double
    var transmission:String

    //MARK: Codingkey Swift will automatically use this as the key type. This therefore allows you to easily customise the keys that your properties are encoded/decoded with.
    enum CodingKeys: String, CodingKey {
         case name         = "name"
         case make         = "make"
         case color        = "color"
         case series       = "series"
         case fuelType     = "fuel_type"
         case fuelLevel    = "fuel_level"
         case transmission = "transmission"
    }
    
}
struct LocationResponse:Codable {
    var latitude:Double
    var longitude:Double
}


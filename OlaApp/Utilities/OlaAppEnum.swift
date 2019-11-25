//
//  OlaAppEnum.swift
//  OlaApp
//
//  Created by Muneer KK on 22/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//
import Foundation


// MARK: TableViewCellIdentifier -
enum TableViewCellIdentifier:String {
    case taxiCellID                  = "taxiCellID"
    
}
// MARK: ViewIdentifier -
enum ViewCellIdentifier:String {
   case annotationView              = "AnnotationViewID"
}

//MARK: - FuelType Enum
enum FuelType: String {
    case petrol = "Petrol"
    case diesel = "Diesel"
    static func getFuelValue(type : String ) -> FuelType? {
        switch type {
        case "P":
            return .petrol
        case "D":
            return .diesel
        default:
            return nil
        }
    }
}

// MARK: StoryboardIdentifier -
enum StoryboardIdentifier: String {
    case splashVCID                 = "splashVCID"
    case taxiListVCID               = "taxiListVCID"
    case taxiMapVCID                = "taxiMapVCID"
    
}
// MARK: Storyboard -
enum StoryboardName: String {
    case main                        = "Main"
}

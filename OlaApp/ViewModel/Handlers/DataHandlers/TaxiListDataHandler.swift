//
//  TaxiListDataHandler.swift
//  OlaApp
//
//  Created by Muneer KK on 22/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MapKit
class TaxiListDataHandler: BaseDataHandler {
    
    func loadAllTaxiDetails() -> [Taxi] {
        let moc = coreDataManager.mainContext
        let productFetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest (entityName: "Taxi")
        do {
            let fetchedTaxiList = try moc?.fetch(productFetch) as! [Taxi]
            return fetchedTaxiList
        }
        catch {
            fatalError("Failed to fetch: \(error)")
        }
    }
    //MARK: - DB handling for Taxi List
    func saveTaxiList(_ response:[TaxiResponse], completionBlock:@escaping DataHandlerCompletionBlock) {
        
        //MARK:- fetch saved Taxi List
        var taxi:Taxi?
        let writeContext = coreDataManager.createWriteContext()
        
        //MARK:- Check if any Taxi is being deleted
        checkForDeletedTaxi(responseData: response)
        
        //MARK:- Update Taxi List
        for (index, taxiObj) in response.enumerated() {
            taxi = nil
            //MARK:- check for Taxi object else create new one
            taxi = taxiWith(taxiObj.uniqueID, context: nil)
            if taxi == nil {
                taxi = NSEntityDescription.insertNewObject(forEntityName: "Taxi", into: writeContext!) as? Taxi
             }
            let taxiDetails = NSEntityDescription.insertNewObject(forEntityName: "TaxiDetails", into: (taxi?.managedObjectContext)!) as? TaxiDetails
            let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: (taxi?.managedObjectContext)!) as? Location
            
            // MARK:- This needs to update in future with NSManagedObjects & Codable. 
            taxi?.uniqueID = taxiObj.uniqueID
            taxi?.modelID = taxiObj.modelID
            taxi?.modelName = taxiObj.modelName
            taxi?.group = taxiObj.group
            taxi?.vehicleNumber = taxiObj.vehicleNumber
            taxi?.status = taxiObj.status
            taxi?.imgUrl = taxiObj.imgUrl
            taxiDetails?.name = taxiObj.taxiDetails.name
            taxiDetails?.make = taxiObj.taxiDetails.make
            taxiDetails?.color = taxiObj.taxiDetails.color
            taxiDetails?.series = taxiObj.taxiDetails.series
            taxiDetails?.fuelType = taxiObj.taxiDetails.fuelType
            taxiDetails?.fuelLevel = taxiObj.taxiDetails.fuelLevel
            taxiDetails?.transmission = taxiObj.taxiDetails.transmission
            location?.latitude = taxiObj.location.latitude
            location?.longitude = taxiObj.location.longitude
            taxi?.taxiDetails = taxiDetails
            taxi?.location = location
            
            coreDataManager.saveAllWithContext((taxi?.managedObjectContext)!) { (errorObject) -> Void in
                if index == response.count - 1{
                    completionBlock(errorObject)
                }
            }
        }
    }
    //MARK:- check for deleted Taxi
    func checkForDeletedTaxi( responseData : [TaxiResponse]) {
        let taxiObjects:[Taxi] = loadAllTaxiDetails()
        for taxiObj in taxiObjects {
            if responseData.contains(where: { $0.uniqueID == taxiObj.uniqueID }) == false{
               taxiObj.managedObjectContext?.delete(taxiObj)
            }
        }
    }
    //MARK:- Fetch Taxi Object with Taxi ID
    func taxiWith(_ taxiID:String, context:NSManagedObjectContext?) -> Taxi? {
        let moc = context ?? coreDataManager.mainContext
        let productFetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest (entityName: "Taxi")
        productFetch.predicate = NSPredicate(format:"uniqueID == %@",taxiID)
        do {
            let fetchedProducts = try moc?.fetch(productFetch) as! [Taxi]
            if fetchedProducts.count > 0 {
                return fetchedProducts.first
            }else {
                return nil
            }
        }
        catch {
            fatalError("Failed to fetch: \(error)")
        }
    }
    // MARK:- Create MapView Location Annoatation Objects
    func getAnnotations(from locations: [Location])->[MKAnnotation] {
        var annotations = [MKPointAnnotation]()
        for location in locations {
            let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            annotations.append(annotation)
        }
        return annotations
    }
    // MARK:- Get Region from Annoatation Objects
    //MARK:- Region is assuming the first object location and it's delta values
    func getRegion(from locations: [Location])->MKCoordinateRegion? {
        if let location = locations.first {
            let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            return MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: OlaAppConstants.latitudeDelta, longitudeDelta: OlaAppConstants.longitudeDelta))
        }
        return nil
    }
}

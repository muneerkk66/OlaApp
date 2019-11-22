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
        var product:Taxi?
        let writeContext = coreDataManager.createWriteContext()
        
        //MARK:- Check if any Taxi is being deleted
        checkForDeletedTaxi(responseData: response)
        
        //MARK:- Update Taxi List
        for (index, taxiObj) in response.enumerated() {
            product = nil
            //MARK:- check for Taxi object else create new one
            product = taxiWith(taxiObj.uniqueID, context: nil)
            if product == nil {
                product = NSEntityDescription.insertNewObject(forEntityName: "Taxi", into: writeContext!) as? Taxi
             }
            coreDataManager.saveAllWithContext((product?.managedObjectContext)!) { (errorObject) -> Void in
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
}

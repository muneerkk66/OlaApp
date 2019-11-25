//
// TaxiListVM.swift
//  OlaApp
//
//  Created by Muneer KK on 22/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class TaxiListVM :BaseVM {
    var apiHandler:TaxiListAPIHandler = TaxiListAPIHandler()
    var dataHandler:TaxiListDataHandler = TaxiListDataHandler()
    var taxiList = [Taxi]()
    //MARK: - Fetch Taxi Details From API
    func fetchTaxiDetails(onCompletion:@escaping VMCompletionBlock){
        apiHandler.getTaxiDetails() {[weak self] (responseObject, errorObject) -> () in
            guard let weakSelf = self else {
                           return
            }
            guard let response = responseObject as? Data else {
                DispatchQueue.main.async {
                    onCompletion(errorObject)
                }
                return
            }
            do {
                // We have used Codable & Decodable for json encoding & decoding
                let taxiObject = try JSONDecoder().decode([TaxiResponse].self, from: response)
                weakSelf.dataHandler.saveTaxiList(taxiObject, completionBlock: { (error) in
                                              DispatchQueue.main.async {
                                                onCompletion(error)}
                })
                               
            } catch {
                     onCompletion(error)
            }
           
                       
        }
    }
    
    //MARK:- Method that returns list of saved Taxi Ojects
    func loadTaxiList() -> [Taxi] {
        return dataHandler.loadAllTaxiDetails()
    }
    
    //MARK:- Method that returns Annonations list from Location objects
    func getAnnotations(from locations:[Location]) -> [MKAnnotation] {
        return dataHandler.getAnnotations(from: locations)
    }
    //MARK:- Method that returns Region
    func getRegion(from locations:[Location]) -> MKCoordinateRegion? {
        return dataHandler.getRegion(from: locations)
    }
       
}

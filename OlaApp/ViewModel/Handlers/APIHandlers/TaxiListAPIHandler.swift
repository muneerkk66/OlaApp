//
//  TaxiListAPIHandler.swift
//  OlaApp
//
//  Created by Muneer KK on 18/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//
import Foundation
class TaxiListAPIHandler: BaseAPIHandler {
    
    func getTaxiDetails(_ onCompletion:@escaping ApiCompletionBlock) {
        let components = URLComponents(string: networkManager.baseURL + OlaAppConstants.APIUrls.taxiDetails.rawValue)
        guard let urlpath = components?.string else {
            return
        }
        networkManager.getRequestPath(url: urlpath, parameters: nil) {(responseObject, errorObject) -> () in
        
            onCompletion(responseObject, errorObject)
        }
    }
}

//
//  OlaAppConstants.swift
//  OlaApp
//
//  Created by Muneer KK on 22/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//
import Foundation
import UIKit
class OlaAppConstants: NSObject {
    
     //MARK:- URL & API details
     enum BaseURL:String {
           case production         = "https://www.mocky.io"
          // case test             = "http://www.mocky.io
    }
    enum APIUrls:String {
        case taxiDetails           = "/v2/5dc3f2c13000003c003477a0"
    }
    
    
    //MARK:- Pointed Server
    static let baseURL             =  BaseURL.production.rawValue
    
    
    //MARK:- Device Constants
    static let screenHeight        = UIScreen.main.bounds.size.height
    static let screenWidth         = UIScreen.main.bounds.size.width

    

   
}

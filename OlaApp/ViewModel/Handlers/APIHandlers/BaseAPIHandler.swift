//  BaseAPIHandler.swift
//  OlaApp
//
//  Created by Muneer KK on 22/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import Foundation
import UIKit

class BaseAPIHandler: NSObject {
    //MARK: - Common completetionblock for API classes
    internal typealias ApiCompletionBlock = (_ responseObject : AnyObject?, _ errorObject : NSError?) -> ()
    internal var networkManager : NetworkManager = NetworkManager()

    //MARK: - initializers
    override init(){
    }

}

//
//  BaseVM.swift
//  OlaApp
//
//  Created by Muneer KK on 22/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import Foundation
class BaseVM: NSObject {
    //MARK: - Common completetionblock for VM classes
    internal typealias VMDataCompletionBlock = (_ responseObject : Any?, _ errorObject : NSError?) -> ()
    internal typealias VMCompletionBlock = (_ errorObject : Error?) -> ()
}

//
//  Playbasis.swift
//  Playbook
//
//  Created by Médéric Petit on 6/14/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

open class PlaybasisSDK: NSObject {
    
    open static let sharedInstance = PlaybasisSDK()
    
    var apiKey:String!
    var apiSecret:String!
    var apiUrl:String!
    
    open class func initWithApiKey(_ apiKey:String, apiSecret:String, apiUrl:String) {
        let playbasis = PlaybasisSDK.sharedInstance
        playbasis.apiKey = apiKey
        playbasis.apiSecret = apiSecret
        playbasis.apiUrl = apiUrl
    }
    
    open func logout() {
        PBDataManager.sharedInstance.clearToken()
    }
    
    open func cancelAllRequests() {
        PBBaseRestController.sharedInstance.cancelAll()
    }
}

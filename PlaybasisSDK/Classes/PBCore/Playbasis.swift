//
//  Playbasis.swift
//  Playbook
//
//  Created by Médéric Petit on 6/14/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

public class Playbasis: NSObject {
    
    public static let sharedInstance = Playbasis()
    
    var apiKey:String!
    var apiSecret:String!
    var apiUrl:String!
    
    public class func initWithApiKey(apiKey:String, apiSecret:String, apiUrl:String) {
        let playbasis = Playbasis.sharedInstance
        playbasis.apiKey = apiKey
        playbasis.apiSecret = apiSecret
        playbasis.apiUrl = apiUrl
    }
    
    public func logout() {
        PBDataManager.sharedInstance.clearToken()
    }
    
    public func cancelAllRequests() {
        PBBaseRestController.sharedInstance.cancelAll()
    }
}

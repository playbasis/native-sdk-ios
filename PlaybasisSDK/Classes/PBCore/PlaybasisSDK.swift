//
//  Playbasis.swift
//  Playbook
//
//  Created by Médéric Petit on 6/14/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

public class PlaybasisSDK: NSObject {
    
    public static let sharedInstance = PlaybasisSDK()
    
    var apiKey:String!
    var apiSecret:String!
    var apiUrl:String!
    
    public class func initWithApiKey(apiKey:String, apiSecret:String, apiUrl:String) {
        let playbasis = PlaybasisSDK.sharedInstance
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

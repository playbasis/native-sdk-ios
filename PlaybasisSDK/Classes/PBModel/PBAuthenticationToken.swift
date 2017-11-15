//
//  AuthenticationToken.swift
//  Idea
//
//  Created by Médéric Petit on 4/20/2559 BE.
//  Copyright © 2559 playbasis. All rights reserved.
//

import UIKit
import SAMKeychain
import ObjectMapper

let expirationDateKey:String = "expirationDateKey"

class PBAuthenticationToken: Mappable {
    
    var token:String? = nil
    var expirationDate:Date? = nil
    
    init(apiResponse:PBApiResponse) {
        Mapper<PBAuthenticationToken>().map(apiResponse.parsedJson, toObject: self)
    }
    
    init() {
        self.getFromKeychain()
    }
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        expirationDate <- (map["date_expire"], ISO8601DateTransform())
        self.saveInKeychain()
    }
    
    func isExpiredOrInvalid() -> Bool {
        return expirationDate == nil || self.token == nil || (expirationDate!.compare(Date()) == .orderedAscending || expirationDate!.compare(Date()) == .orderedSame)
    }
    
    fileprivate func saveInKeychain() {
        if let token = self.token {
            PBDataManager.sharedInstance.saveToken(token, withType: .AuthenticationToken)
            PBDataManager.sharedInstance.saveValue(expirationDate, forKey: expirationDateKey)
        }
    }
    
    fileprivate func clearKeyChain() {
        PBDataManager.sharedInstance.clearToken()
        PBDataManager.sharedInstance.unsetValueFromKey(expirationDateKey)
    }
    
    func getFromKeychain() {
        self.token = PBDataManager.sharedInstance.getTokenWithType(.AuthenticationToken)
        self.expirationDate = PBDataManager.sharedInstance.value(forKey: expirationDateKey) as? Date
    }
    
    func invalidate() {
        self.token = nil
        self.expirationDate = nil
        self.clearKeyChain()
    }
}

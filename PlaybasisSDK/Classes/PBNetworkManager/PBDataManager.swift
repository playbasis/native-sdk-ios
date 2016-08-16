//
//  UserDataManager.swift
//  StrollGuam
//
//  Created by Médéric Petit on 4/19/2559 BE.
//  Copyright © 2559 playbasis. All rights reserved.
//

import UIKit
import SAMKeychain

enum PBTokenType: String {
    case AuthenticationToken
}

class PBDataManager: NSObject {
    

    static let sharedInstance = PBDataManager()
    let accountName:String = NSBundle.mainBundle().bundleIdentifier!

    private func getTokenString(tokenType:PBTokenType) -> String? {
        
        if let token =  SAMKeychain.passwordForService(tokenType.rawValue, account: accountName){
            return token
        }else{
            return nil
        }
        
    }
    
    private func saveTokenString(token:String,tokenType:PBTokenType) -> Bool {
        if token.isEmpty{
            return false
        }else{
            return SAMKeychain.setPassword(token, forService: tokenType.rawValue, account: accountName)
        }
    }
    
    
    func getTokenWithType(tokenType:PBTokenType)-> String?{
        return getTokenString(tokenType)
    }
    
    func saveToken(token:String,withType type:PBTokenType)-> Bool{
        return self.saveTokenString(token, tokenType: type)
    }
    
    func clearToken() {
        SAMKeychain.deletePasswordForService(PBTokenType.AuthenticationToken.rawValue, account: accountName)
    }

    
    func saveValue(value: AnyObject?, forKey key: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(value, forKey: key)
        userDefaults.synchronize()
    }
    
    func unsetValueFromKey(key:String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey(key)
        userDefaults.synchronize()
    }
    
    func saveBool(bool: Bool, forKey key: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(bool, forKey: key)
        userDefaults.synchronize()
    }
    
    func boolForKey(key:String) -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.boolForKey(key)
    }
    
    func saveInt(int: Int, forKey key: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(int, forKey: key)
        userDefaults.synchronize()
    }
    
    func intForKey(key:String) -> Int {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.integerForKey(key)
    }
    
    override func valueForKey(key: String) -> AnyObject? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.objectForKey(key)
    }
}

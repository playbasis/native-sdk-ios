//
//  UserDataManager.swift
//  StrollGuam
//
//  Created by Médéric Petit on 4/19/2559 BE.
//  Copyright © 2559 playbasis. All rights reserved.
//

import UIKit
import SAMKeychain

public enum PBTokenType: String {
    case AuthenticationToken
}

public class PBDataManager: NSObject {
    

    public static let sharedInstance = PBDataManager()
    public let accountName:String = NSBundle.mainBundle().bundleIdentifier!

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
    
    
    public func getTokenWithType(tokenType:PBTokenType)-> String?{
        return getTokenString(tokenType)
    }
    
    public  func saveToken(token:String,withType type:PBTokenType)-> Bool{
        return self.saveTokenString(token, tokenType: type)
    }
    
    public func clearToken() {
        SAMKeychain.deletePasswordForService(PBTokenType.AuthenticationToken.rawValue, account: accountName)
    }

    
    public func saveValue(value: AnyObject?, forKey key: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(value, forKey: key)
        userDefaults.synchronize()
    }
    
    public func unsetValueFromKey(key:String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey(key)
        userDefaults.synchronize()
    }
    
    public func saveBool(bool: Bool, forKey key: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(bool, forKey: key)
        userDefaults.synchronize()
    }
    
    public func boolForKey(key:String) -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.boolForKey(key)
    }
    
    public func saveInt(int: Int, forKey key: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(int, forKey: key)
        userDefaults.synchronize()
    }
    
    public func intForKey(key:String) -> Int {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.integerForKey(key)
    }
    
    public override func valueForKey(key: String) -> AnyObject? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.objectForKey(key)
    }
}

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

open class PBDataManager: NSObject {
    

    open static let sharedInstance = PBDataManager()
    open let accountName:String = Bundle.main.bundleIdentifier ?? "com.playbasis.ios.sdk"

    fileprivate func getTokenString(_ tokenType:PBTokenType) -> String? {
        
        if let token =  SAMKeychain.password(forService: tokenType.rawValue, account: accountName){
            return token
        }else{
            return nil
        }
        
    }
    
    fileprivate func saveTokenString(_ token:String,tokenType:PBTokenType) -> Bool {
        if token.isEmpty{
            return false
        }else{
            return SAMKeychain.setPassword(token, forService: tokenType.rawValue, account: accountName)
        }
    }
    
    
    open func getTokenWithType(_ tokenType:PBTokenType)-> String?{
        return getTokenString(tokenType)
    }
    
    @discardableResult open  func saveToken(_ token:String,withType type:PBTokenType)-> Bool{
        return self.saveTokenString(token, tokenType: type)
    }
    
    open func clearToken() {
        SAMKeychain.deletePassword(forService: PBTokenType.AuthenticationToken.rawValue, account: accountName)
    }

    
    open func saveValue(_ value: Any?, forKey key: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    open func unsetValueFromKey(_ key:String) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key)
        userDefaults.synchronize()
    }
    
    open func saveBool(_ bool: Bool, forKey key: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(bool, forKey: key)
        userDefaults.synchronize()
    }
    
    open func boolForKey(_ key:String) -> Bool {
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: key)
    }
    
    open func saveInt(_ int: Int, forKey key: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(int, forKey: key)
        userDefaults.synchronize()
    }
    
    open func intForKey(_ key:String) -> Int {
        let userDefaults = UserDefaults.standard
        return userDefaults.integer(forKey: key)
    }
    
    open override func value(forKey key: String) -> Any? {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: key)
    }
}

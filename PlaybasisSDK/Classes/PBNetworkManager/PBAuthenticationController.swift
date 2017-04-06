//
//  AuthenticationController.swift
//  NetworkManager
//
//  Created by Médéric Petit on 6/7/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

class PBAuthenticationController {
    
    static let sharedInstance = PBAuthenticationController()
    
    var authenticationToken:PBAuthenticationToken! = PBAuthenticationToken()
    
    func invalidateToken() {
        self.authenticationToken.invalidate()
    }
    
}

extension PBAuthenticationController { // API
    
    func renewAuthenticationTokenIfNeeded(_ completionBlock:@escaping PBEmptyCompletionBlock) {
        if self.authenticationToken.isExpiredOrInvalid() {
            PBAuthenticationApi.renew({ (authenticationToken) in
                self.authenticationToken = authenticationToken
                completionBlock()
                }, failureBlock: { (error) in
                    completionBlock()
            })
        }
        else {
            completionBlock()
        }
        
    }
}

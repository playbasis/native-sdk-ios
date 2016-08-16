//
//  PBAuthenticationApi.swift
//  Playbook
//
//  Created by Médéric Petit on 6/14/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

class PBAuthenticationApi: PBBaseApi {
        
    class func authenticate(successBlock:PBAuthenticationCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params = ["api_key":Playbasis.sharedInstance.apiKey, "api_secret":Playbasis.sharedInstance.apiSecret]
        PBRestController.request(.POST, endPoint: PBEndPoint.AUTHENTICATION_END_POINT, parameters: params, completionBlock: { (apiResponse) in
            let authenticationToken:PBAuthenticationToken = PBAuthenticationToken(apiResponse: apiResponse)
            successBlock(authenticationToken: authenticationToken)
            }, failureBlock:failureBlock)
    }
    
    class func renew(successBlock:PBAuthenticationCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params = ["api_key":Playbasis.sharedInstance.apiKey, "api_secret":Playbasis.sharedInstance.apiSecret]
        PBRestController.request(.POST, endPoint: PBEndPoint.AUTHENTICATION_END_POINT, parameters: params, completionBlock: { (apiResponse) in
            let authenticationToken:PBAuthenticationToken = PBAuthenticationToken(apiResponse: apiResponse)
            successBlock(authenticationToken: authenticationToken)
            }, failureBlock:failureBlock)
    }
}

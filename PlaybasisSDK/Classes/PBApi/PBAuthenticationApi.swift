//
//  PBAuthenticationApi.swift
//  Playbook
//
//  Created by Médéric Petit on 6/14/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

class PBAuthenticationApi: PBBaseApi {
        
    class func authenticate(_ successBlock:@escaping PBAuthenticationCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        let params = ["api_key":PlaybasisSDK.sharedInstance.apiKey, "api_secret":PlaybasisSDK.sharedInstance.apiSecret]
        PBRestController.request(.post, endPoint: PBEndPoint.AUTHENTICATION_END_POINT, parameters: params as [String : AnyObject], completionBlock: { (apiResponse) in
            let authenticationToken:PBAuthenticationToken = PBAuthenticationToken(apiResponse: apiResponse)
            successBlock(authenticationToken)
            }, failureBlock:failureBlock)
    }
    
    class func renew(_ successBlock:@escaping PBAuthenticationCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        let params = ["api_key":PlaybasisSDK.sharedInstance.apiKey, "api_secret":PlaybasisSDK.sharedInstance.apiSecret]
        PBRestController.request(.post, endPoint: PBEndPoint.AUTHENTICATION_END_POINT, parameters: params as [String : AnyObject], completionBlock: { (apiResponse) in
            let authenticationToken:PBAuthenticationToken = PBAuthenticationToken(apiResponse: apiResponse)
            successBlock(authenticationToken)
            }, failureBlock:failureBlock)
    }
}

//
//  PlaybasisRestController.swift
//  NetworkManager
//
//  Created by Médéric Petit on 6/7/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import Alamofire

class PBRestController {
    
    class func uploadData(_ data:Data, endPoint: String, parameters: [String : AnyObject]?, encoding: ParameterEncoding = URLEncoding.httpBody, headers: [String: String]? = nil, completionBlock: @escaping ((PBApiResponse) -> Void), failureBlock:@escaping PBFailureErrorBlock) {
        
        Alamofire.SessionManager.default.delegate.taskWillPerformHTTPRedirection = nil
        
        func handleBadToken(_ error:PBError) -> Bool {
            if error.remoteError == .invalidToken {
                PBAuthenticationController.sharedInstance.invalidateToken()
                self.uploadData(data, endPoint: endPoint, parameters: parameters, encoding: encoding, headers: headers, completionBlock: completionBlock, failureBlock: failureBlock)
                return true
            }
            return false
        }
        
        PBAuthenticationController.sharedInstance.renewAuthenticationTokenIfNeeded({
            let request = PBBaseRestController.sharedInstance.createRequest(endPoint, method: .post, authenticationData: [:], encoding: encoding, headers: headers, parameters: parameters)
            let authenticationData:[String:String] = ["token":PBAuthenticationController.sharedInstance.authenticationToken.token!]
            PBBaseRestController.sharedInstance.performUpload(request, data:data, authenticationData: authenticationData, completionBlock:completionBlock, failureBlock:{ (error) in
                if handleBadToken(error) == false {
                    failureBlock(error)
                }
            })
        })
    }

    class func request(_ method:Alamofire.HTTPMethod, endPoint: String, parameters: [String : String]? = nil, asynchronous:Bool = true, encoding: ParameterEncoding = URLEncoding.httpBody, headers: [String: String]? = nil, completionBlock: @escaping ((PBApiResponse) -> Void), failureBlock:@escaping PBFailureErrorBlock) {
        request(method, endPoint: endPoint, parameters: parameters as [String: AnyObject]?, asynchronous: asynchronous, encoding: encoding, headers: headers, completionBlock: completionBlock, failureBlock: failureBlock)
    }

    class func request(_ method:Alamofire.HTTPMethod, endPoint: String, parameters: [String : AnyObject]?, asynchronous:Bool = true, encoding: ParameterEncoding = URLEncoding.httpBody, headers: [String: String]? = nil, completionBlock: @escaping ((PBApiResponse) -> Void), failureBlock:@escaping PBFailureErrorBlock) {
        
        func handleBadToken(_ error:PBError) -> Bool {
            if error.remoteError == .invalidToken {
                PBAuthenticationController.sharedInstance.invalidateToken()
                self.request(method, endPoint: endPoint, parameters: parameters, encoding: encoding, headers: headers, completionBlock: completionBlock, failureBlock: failureBlock)
                return true
            }
            return false
        }
        var authenticationData:[String:String] = [:]
        
        if endPoint != PBEndPoint.AUTHENTICATION_END_POINT && method != .get {
            PBAuthenticationController.sharedInstance.renewAuthenticationTokenIfNeeded({
                if method == .post, let token = PBAuthenticationController.sharedInstance.authenticationToken.token {
                    authenticationData["token"] = token
                    print("Token: \(token)")
                }
                let request = PBBaseRestController.sharedInstance.createRequest(endPoint, method: method, authenticationData: authenticationData, encoding: encoding, headers: headers, parameters: parameters)
                PBBaseRestController.sharedInstance.performRequest(request, asynchronous: asynchronous, completionBlock: completionBlock, failureBlock: { (error) in
                    if handleBadToken(error) == false {
                        failureBlock(error)
                    }
                    
                })
            })
        }
        else {
            authenticationData["api_key"] = PlaybasisSDK.sharedInstance.apiKey
            let request = PBBaseRestController.sharedInstance.createRequest(endPoint, method: method, authenticationData:authenticationData, encoding: encoding, headers: headers, parameters: parameters)
            PBBaseRestController.sharedInstance.performRequest(request, asynchronous: asynchronous, completionBlock: completionBlock, failureBlock: { (error) in
                if handleBadToken(error) == false {
                    failureBlock(error)
                }
            })
        }
        
    }

}

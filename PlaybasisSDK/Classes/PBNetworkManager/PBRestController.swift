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
    
    class func uploadData(data:NSData, endPoint: String, parameters: [String : AnyObject]?, encoding: ParameterEncoding = .URL, headers: [String: String]? = nil, completionBlock: ((PBApiResponse) -> Void), failureBlock:PBFailureErrorBlock) {
        
        Alamofire.Manager.sharedInstance.delegate.taskWillPerformHTTPRedirection = nil
        
        func handleBadToken(error:PBError) -> Bool {
            if error.remoteError == .InvalidToken {
                PBAuthenticationController.sharedInstance.invalidateToken()
                self.uploadData(data, endPoint: endPoint, parameters: parameters, encoding: encoding, headers: headers, completionBlock: completionBlock, failureBlock: failureBlock)
                return true
            }
            return false
        }
        
        PBAuthenticationController.sharedInstance.renewAuthenticationTokenIfNeeded({
            let request = PBBaseRestController.sharedInstance.createRequest(endPoint, method: .POST, authenticationData: [:], encoding: encoding, headers: headers, parameters: parameters)
            let authenticationData:[String:String] = ["token":PBAuthenticationController.sharedInstance.authenticationToken.token!]
            PBBaseRestController.sharedInstance.performUpload(request, data:data, authenticationData: authenticationData, completionBlock:completionBlock, failureBlock:{ (error) in
                if handleBadToken(error) == false {
                    failureBlock(error: error)
                }
            })
        })
    }
    
    class func request(method:Alamofire.Method, endPoint: String, parameters: [String : AnyObject]?, asynchronous:Bool = true, encoding: ParameterEncoding = .URL, headers: [String: String]? = nil, completionBlock: ((PBApiResponse) -> Void), failureBlock:PBFailureErrorBlock) {
        
        func handleBadToken(error:PBError) -> Bool {
            if error.remoteError == .InvalidToken {
                PBAuthenticationController.sharedInstance.invalidateToken()
                self.request(method, endPoint: endPoint, parameters: parameters, encoding: encoding, headers: headers, completionBlock: completionBlock, failureBlock: failureBlock)
                return true
            }
            return false
        }
        var authenticationData:[String:String] = [:]
        
        if endPoint != PBEndPoint.AUTHENTICATION_END_POINT && method != .GET {
            PBAuthenticationController.sharedInstance.renewAuthenticationTokenIfNeeded({
                if method == .POST, let token = PBAuthenticationController.sharedInstance.authenticationToken.token {
                    authenticationData["token"] = token
                    print("Token: \(token)")
                }
                let request = PBBaseRestController.sharedInstance.createRequest(endPoint, method: method, authenticationData: authenticationData, encoding: encoding, headers: headers, parameters: parameters)
                PBBaseRestController.sharedInstance.performRequest(request, asynchronous: asynchronous, completionBlock: completionBlock, failureBlock: { (error) in
                    if handleBadToken(error) == false {
                        failureBlock(error: error)
                    }
                    
                })
            })
        }
        else {
            authenticationData["api_key"] = Playbasis.sharedInstance.apiKey
            let request = PBBaseRestController.sharedInstance.createRequest(endPoint, method: method, authenticationData:authenticationData, encoding: encoding, headers: headers, parameters: parameters)
            PBBaseRestController.sharedInstance.performRequest(request, asynchronous: asynchronous, completionBlock: completionBlock, failureBlock: { (error) in
                if handleBadToken(error) == false {
                    failureBlock(error: error)
                }
            })
        }
        
    }

}

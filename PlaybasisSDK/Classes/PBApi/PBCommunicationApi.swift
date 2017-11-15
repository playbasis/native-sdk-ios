//
//  PBCommunicationApi.swift
//  Playbook
//
//  Created by Médéric Petit on 8/15/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

open class PBCommunicationApi: PBBaseApi {

    fileprivate class func pushEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.PUSH_END_POINT + self.encodePath(path)
    }
    
    fileprivate class func emailEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.EMAIL_END_POINT + self.encodePath(path)
    }
    
    open class func registerDeviceWithDeviceForm(_ deviceForm:PBDeviceForm, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        PBRestController.request(.post, endPoint: pushEndPointWithPath("deviceRegistration"), parameters: deviceForm.params(), completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
    open class func deRegisterDeviceWithDeviceToken(_ deviceToken:String, playerId:String, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        let params:[String:String] = ["device_token":deviceToken, "player_id":playerId]
        PBRestController.request(.post, endPoint: pushEndPointWithPath("deviceDeRegistration"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
    open class func sendEmailWithEmailForm(_ emailForm:PBEmailForm, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        PBRestController.request(.post, endPoint: emailEndPointWithPath("send"), parameters: emailForm.params(), completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
    open class func sendCouponEmailWithEmailForm(_ emailForm:PBEmailForm, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        PBRestController.request(.post, endPoint: emailEndPointWithPath("goods"), parameters: emailForm.params(), completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
}

//
//  PBCommunicationApi.swift
//  Playbook
//
//  Created by Médéric Petit on 8/15/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

public class PBCommunicationApi: PBBaseApi {

    private class func pushEndPointWithPath(path:String) -> String {
        return PBEndPoint.PUSH_END_POINT + path
    }
    
    private class func emailEndPointWithPath(path:String) -> String {
        return PBEndPoint.EMAIL_END_POINT + path
    }
    
    public class func registerDeviceWithDeviceForm(deviceForm:PBDeviceForm, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        PBRestController.request(.POST, endPoint: pushEndPointWithPath("deviceRegistration"), parameters: deviceForm.params(), completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
    public class func sendEmailWithEmailForm(emailForm:PBEmailForm, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        PBRestController.request(.POST, endPoint: emailEndPointWithPath("send"), parameters: emailForm.params(), completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
    public class func sendCouponEmailWithEmailForm(emailForm:PBEmailForm, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        PBRestController.request(.POST, endPoint: emailEndPointWithPath("goods"), parameters: emailForm.params(), completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
}

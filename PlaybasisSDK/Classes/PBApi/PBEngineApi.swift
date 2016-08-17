//
//  PBEngineApi.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/16/2559 BE.
//
//

import UIKit

enum RoleAction {
}

class PBEngineApi: PBBaseApi {
    private class func engineEndPointWithPath(path:String) -> String {
        return PBEndPoint.REDEEM_END_POINT + path
    }

    class func processAction(engineForm:PBEngineForm,completionBlock:PBRuleCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.POST, endPoint: engineEndPointWithPath("/rule"), parameters: engineForm.params(), completionBlock: { (response) in
            let rule:PBRule = PBRule(apiResponse:response)
            completionBlock(rule)
        }, failureBlock:failureBlock)
    }
}

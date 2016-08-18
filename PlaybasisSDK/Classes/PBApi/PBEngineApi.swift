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

public class PBEngineApi: PBBaseApi {
    private class func engineEndPointWithPath(path:String) -> String {
        return PBEndPoint.ENGINE_END_POINT + path
    }

    public class func processAction(engineForm:PBEngineForm,completionBlock:PBRuleCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.POST, endPoint: engineEndPointWithPath("rule"), parameters: engineForm.params(), completionBlock: { (response) in
            let rule:PBRule = PBRule(apiResponse:response)
            completionBlock(rule)
        }, failureBlock:failureBlock)
    }
    
    public class func ruleDetailsForPlayer(ruleId:String ,playerId:String,completionBlock:PBRuleCompletionBlock, failureBlock:PBFailureErrorBlock){
        var params:[String:String] = [:]
        params["player_id"] = playerId
        PBRestController.request(.GET, endPoint: engineEndPointWithPath("rule/\(ruleId)"), parameters: nil, completionBlock: { (response) in
            let rule:PBRule = PBRule(apiResponse:response)
            completionBlock(rule)
            }, failureBlock:failureBlock)
    }
}

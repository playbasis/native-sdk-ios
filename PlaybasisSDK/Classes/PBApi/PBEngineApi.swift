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

open class PBEngineApi: PBBaseApi {
    fileprivate class func engineEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.ENGINE_END_POINT + self.encodePath(path)
    }

    open class func processAction(_ engineForm:PBEngineForm,completionBlock:@escaping PBRuleCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        PBRestController.request(.post, endPoint: engineEndPointWithPath("rule"), parameters: engineForm.params(), completionBlock: { (response) in
            let rule:PBRule = PBRule(apiResponse:response)
            completionBlock(rule)
        }, failureBlock:failureBlock)
    }
    
    open class func ruleDetailsWithId(_ ruleId:String, playerId:String?,completionBlock:@escaping PBRuleCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        var params:[String:String] = [:]
        if let mPlayerId:String = playerId {
            params["player_id"] = mPlayerId
        }
        PBRestController.request(.get, endPoint: engineEndPointWithPath("rule/\(ruleId)"), parameters: params, completionBlock: { (response) in
            let rule:PBRule = PBRule(apiResponse:response)
            completionBlock(rule)
            }, failureBlock:failureBlock)
    }
    
    open class func listRulesWithAction(_ action:String?, playerId:String?, completionBlock:@escaping PBGameRulesCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        var params:[String:String] = [:]
        if let mPlayerId:String = playerId {
            params["player_id"] = mPlayerId
        }
        if let mAction:String = action {
            params["action"] = mAction
        }
        PBRestController.request(.get, endPoint: engineEndPointWithPath("rules"), parameters: params, completionBlock: { (apiResponse) in
            
            if apiResponse.parsedJson != nil {
                completionBlock(PBGameRule.pbGameRuleFromApiResponse(apiResponse))
            }
            else {
                failureBlock(PBError(message: "Unknown error"))
            }
            

            }, failureBlock: failureBlock)
    }
}

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

    open class func processAction(_ engineForm:PBEngineForm,completionBlock:PBRuleCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.POST, endPoint: engineEndPointWithPath("rule"), parameters: engineForm.params(), completionBlock: { (response) in
            let rule:PBRule = PBRule(apiResponse:response)
            completionBlock(rule)
        }, failureBlock:failureBlock)
    }
    
    open class func ruleDetailsWithId(_ ruleId:String, playerId:String?,completionBlock:PBRuleCompletionBlock, failureBlock:PBFailureErrorBlock){
        var params:[String:String] = [:]
        if let mPlayerId:String = playerId {
            params["player_id"] = mPlayerId
        }
        PBRestController.request(.GET, endPoint: engineEndPointWithPath("rule/\(ruleId)"), parameters: params, completionBlock: { (response) in
            let rule:PBRule = PBRule(apiResponse:response)
            completionBlock(rule)
            }, failureBlock:failureBlock)
    }
    
    open class func listRulesWithAction(_ action:String?, playerId:String?, completionBlock:PBGameRulesCompletionBlock, failureBlock:PBFailureErrorBlock) {
        var params:[String:String] = [:]
        if let mPlayerId:String = playerId {
            params["player_id"] = mPlayerId
        }
        if let mAction:String = action {
            params["action"] = mAction
        }
        PBRestController.request(.GET, endPoint: engineEndPointWithPath("rules"), parameters: params, completionBlock: { (apiResponse) in
            
            if apiResponse.parsedJson != nil {
                completionBlock(gameRules: PBGameRule.pbGameRuleFromApiResponse(apiResponse))
            }
            else {
                failureBlock(error: PBError(message: "Unknown error"))
            }
            

            }, failureBlock: failureBlock)
    }
}

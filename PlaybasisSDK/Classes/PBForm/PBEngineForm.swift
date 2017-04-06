//
//  PBEngineForm.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/16/2559 BE.
//
//

import UIKit

open class PBEngineForm: PBForm {
    
    // Required
    open var playerId:String!
    open var action:String!
    
    // Optional
    open var url:String?
    open var reward:String?
    open var quantity:String?
    open var ruleId:String?
    open var nodeId:String?
    open var sessionId:String?
    open var customParams:[String:String]?
    
    public override init() {
        super.init()
    }
    
    override open func params() -> [String:String] {
        var params:[String:String] = [:]
        params["player_id"] = playerId
        params["action"] = action
        
        if let mUrl = url {
            params["url"] = mUrl
        }
        if let mReward = reward {
            params["reward"] = mReward
        }
        if let mQuantity = quantity {
            params["quantity"] = mQuantity
        }
        if let mRuleId = ruleId {
            params["rule_id"] = mRuleId
        }
        if let mNodeId = nodeId {
            params["node_id"] = mNodeId
        }
        if let mSessionId = sessionId {
            params["session_id"] = mSessionId
        }
        if let mCustomParams = customParams {
            params += mCustomParams
        }
        
        return params
    }
}

//
//  PBEngineForm.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/16/2559 BE.
//
//

import UIKit

public class PBEngineForm: PBForm {
    
    // Required
    public var playerId:String!
    public var action:String!
    
    // Optional
    public var url:String?
    public var reward:String?
    public var quantity:String?
    public var ruleId:String?
    public var nodeId:String?
    public var sessionId:String?
    
    public override init() {
        super.init()
    }
    
    override public func params() -> [String:String] {
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
        
        return params
    }
}

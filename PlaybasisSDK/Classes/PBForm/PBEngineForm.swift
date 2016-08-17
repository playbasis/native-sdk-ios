//
//  PBEngineForm.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/16/2559 BE.
//
//

import UIKit

public class PBEngineForm: PBForm {
    
    public var playerId:String! = ""
    public var url:String! = ""
    public var reward:String! = ""
    public var quantity:String! = ""
    public var ruleId:String! =  ""
    public var nodeId:String! = ""
    public var sessionId:String! = ""
    public var engineActionName:String! = ""
    
    
    public override init() {
        super.init()
    }
    
    override public func params() -> [String:String] {
        var params:[String:String] = [:]
        params["player_id"] = playerId!
        params["url"] = url
        params["reward"] = reward
        params["quantity"] = quantity
        params["rule_id"] = ruleId
        params["node_id"] = nodeId
        params["session_id"] = sessionId
        params["action"] = engineActionName
        
        return params
    }
}

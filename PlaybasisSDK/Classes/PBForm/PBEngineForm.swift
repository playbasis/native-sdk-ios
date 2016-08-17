//
//  PBEngineForm.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/16/2559 BE.
//
//

import UIKit

enum EngineAction:String {
    case Click = "click"
    case Like = "like"
    case OnClick = "onclick"
}

class PBEngineForm: PBForm {
    
    var playerId:String! = ""
    var url:String! = ""
    var reward:String! = ""
    var quantity:String! = ""
    var ruleId:String! =  ""
    var nodeId:String! = ""
    var sessionId:String! = ""
    var action:EngineAction! = .Click
    
    
    init(playerId:String,action:EngineAction) {
        self.playerId = playerId
        self.action = action
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
        params["action"] = action.rawValue
        
        return params
    }
}

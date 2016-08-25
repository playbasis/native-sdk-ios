//
//  PBEmailForm.swift
//  PayAndPlayDemo
//
//  Created by Médéric Petit on 8/19/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

public class PBEmailForm: PBForm {
    
    // Required
    public var playerId:String!
    public var subject:String!
    
    // Optional
    public var message:String?
    public var templateId:String?
    public var refId:String?
    
    public override init() {
        super.init()
    }
    
    override public func params() -> [String:String] {
        var params:[String:String] = [:]
        params["player_id"] = playerId
        params["subject"] = subject
        
        if let mMessage = message {
            params["message"] = mMessage
        }
        if let mTemplateId = templateId {
            params["template_id"] = mTemplateId
        }
        if let mRefId = refId {
            params["ref_id"] = mRefId
        }
        
        return params
    }

}

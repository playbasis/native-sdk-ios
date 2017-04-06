//
//  PBEmailForm.swift
//  PayAndPlayDemo
//
//  Created by Médéric Petit on 8/19/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

open class PBEmailForm: PBForm {
    
    // Required
    open var playerId:String!
    open var subject:String!
    
    // Optional
    open var message:String?
    open var templateId:String?
    open var refId:String?
    
    public override init() {
        super.init()
    }
    
    override open func params() -> [String:String] {
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

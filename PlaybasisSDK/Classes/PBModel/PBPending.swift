//
//  PBPending.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/23/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBPending: PBModel {
    
    public var eventType:String! = ""
    public var message:String! = ""
    public var incomplete:PBIncomplete?
 
    override public func mapping(map: Map) {
        super.mapping(map)
        self.eventType <- map["event_type"]
        self.message <- map["message"]
        self.incomplete <- map["incomplete"]
        
    }
}

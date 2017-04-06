//
//  PBPending.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/23/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBPending: PBModel {
    
    open var eventType:String! = ""
    open var message:String! = ""
    open var incomplete:PBIncomplete?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
 
    override open func mapping(_ map: Map) {
        super.mapping(map)
        self.eventType <- map["event_type"]
        self.message <- map["message"]
        self.incomplete <- map["incomplete"]
        
    }
}

//
//  PBCompletionData.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/21/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBCompletionData: PBModel {
    open var actionId:String?
    open var name:String?
    open var desc:String?
    open var icon:String?
    open var color:String?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override open func mapping(_ map: Map) {
        super.mapping(map)
        name <- map["name"]
        desc <- map["description"]
        icon <- map["icon"]
        color <- map["color"]
        actionId <- map["action_id"]
    }
}

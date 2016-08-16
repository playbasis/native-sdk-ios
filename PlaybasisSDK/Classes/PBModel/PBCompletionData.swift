//
//  PBCompletionData.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/21/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBCompletionData: PBModel {
    public var actionId:String?
    public var name:String?
    public var desc:String?
    public var icon:String?
    public var color:String?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        name <- map["name"]
        desc <- map["description"]
        icon <- map["icon"]
        color <- map["color"]
        actionId <- map["action_id"]
    }
}

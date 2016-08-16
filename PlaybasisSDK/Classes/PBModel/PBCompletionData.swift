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
    var actionId:String?
    var name:String?
    var desc:String?
    var icon:String?
    var color:String?
    
    
    override public func mapping(map: Map) {
        super.mapping(map)
        name <- map["name"]
        desc <- map["description"]
        icon <- map["icon"]
        color <- map["color"]
        actionId <- map["action_id"]
    }
}

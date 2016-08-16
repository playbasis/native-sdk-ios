//
//  PBCompletion.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/21/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBCompletion: PBModel {

    var title:String! = ""
    var type:String! = ""
    var value:String! = ""
    var filter:String?
    var elementId:String?
    var missionId:String?
    var completionOp:String?
    var completionId:String?
    var completionData:PBCompletionData?
    
    
    override public func mapping(map: Map) {
        super.mapping(map)
        completionOp <- map["completion_op"]
        completionId <- map["completion_id"]
        title <- map["completion_title"]
        type <- map["completion_type"]
        value <- map["completion_value"]
        filter <- map["completion_filter"]
        elementId <- map["completion_element_id"]
        missionId <- map["mission_id"]
        completionData <- map["completion_data"]
    
    }
}

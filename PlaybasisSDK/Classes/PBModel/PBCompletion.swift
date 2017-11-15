//
//  PBCompletion.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/21/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBCompletion: PBModel {

    open var title:String! = ""
    open var type:String! = ""
    open var value:String! = ""
    open var filter:String?
    open var elementId:String?
    open var missionId:String?
    open var completionOp:String?
    open var completionId:String?
    open var completionData:PBCompletionData?
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
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

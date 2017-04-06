//
//  PBCondition.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/22/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBCondition: PBModel {

    open var conditionId:String?
    open var type:String?
    open var value:String?
    open var conditionData:[PBConditionData] = []
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public override init() {
        super.init()
    }
    
    override open func mapping(_ map: Map) {
        super.mapping(map)
        conditionId <- map["condition_id"]
        type <- map["condition_type"]
        value <- map["condition_value"]
        conditionData <- map["condition_data"]

    }
}

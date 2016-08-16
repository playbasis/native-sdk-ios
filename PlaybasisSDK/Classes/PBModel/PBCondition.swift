//
//  PBCondition.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/22/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

class PBCondition: PBModel {

    var conditionId:String?
    var type:String?
    var value:String?
    var conditionData:[PBConditionData] = []
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    
    override func mapping(map: Map) {
        super.mapping(map)
        conditionId <- map["condition_id"]
        type <- map["condition_type"]
        value <- map["condition_value"]
        conditionData <- map["condition_data"]

    }
}

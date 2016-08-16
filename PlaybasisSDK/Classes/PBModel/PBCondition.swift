//
//  PBCondition.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/22/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBCondition: PBModel {

    public var conditionId:String?
    public var type:String?
    public var value:String?
    public var conditionData:[PBConditionData] = []
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public override init() {
        super.init()
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        conditionId <- map["condition_id"]
        type <- map["condition_type"]
        value <- map["condition_value"]
        conditionData <- map["condition_data"]

    }
}

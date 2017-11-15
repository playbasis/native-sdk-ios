//
//  PBRuleRewardDetails.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/17/2559 BE.
//
//

import UIKit
import ObjectMapper

open class PBRuleRewardDetails: PBModel {
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
    }

}

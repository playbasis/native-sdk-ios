//
//  PBRuleReward.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/17/2559 BE.
//
//

import UIKit
import ObjectMapper


public class PBRuleReward: PBModel {
    
    public var rewards:[PBReward] = []
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
    }

}

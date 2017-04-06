//
//  PBBranch.swift
//  Pods
//
//  Created by Médéric Petit on 8/25/2559 BE.
//
//

import ObjectMapper

open class PBBranch: PBModel {
    
    open var name:String!
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override open func mapping(_ map: Map) {
        super.mapping(map)
        uid <- map["b_id"]
        name <- map["b_name"]
    }

}

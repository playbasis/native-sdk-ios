//
//  PBMerchant.swift
//  Pods
//
//  Created by Médéric Petit on 8/25/2559 BE.
//
//

import ObjectMapper

open class PBMerchant: PBModel {

    open var name:String!
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        uid <- map["id"]
        name <- map["name"]
    }
    
}

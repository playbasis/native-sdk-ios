//
//  PBMerchant.swift
//  Pods
//
//  Created by Médéric Petit on 8/25/2559 BE.
//
//

import ObjectMapper

public class PBMerchant: PBModel {

    public var name:String!
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBMerchant>().map(apiResponse.parsedJson!["merchant"], toObject: self)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        uid <- map["id"]
        name <- map["name"]
    }
    
}

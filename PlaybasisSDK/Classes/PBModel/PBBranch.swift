
//
//  PBBranch.swift
//  Pods
//
//  Created by Médéric Petit on 8/25/2559 BE.
//
//

import ObjectMapper

public class PBBranch: PBModel {
    
    public var name:String!
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        uid <- map["b_id"]
        name <- map["b_name"]
    }
    
    class func pbBranchesFromApiResponse(apiResponse:PBApiResponse) -> [PBBranch] {
        var branches:[PBBranch] = []
        branches = Mapper<PBBranch>().mapArray(apiResponse.parsedJson!["branch"]) ?? []
        return branches
    }

}

//
//  PBRedeemPlace.swift
//  Pods
//
//  Created by Médéric Petit on 8/25/2559 BE.
//
//

import ObjectMapper

class PBRedeemPlace: PBModel {

    public var branches:[PBBranch]?
    public var merchant:PBMerchant?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        branches <- map["branch"]
        merchant <- map["merchant"]
    }
    
    class func pbRedeemPlacesFromApiResponse(apiResponse:PBApiResponse) -> [PBRedeemPlace] {
        var redeemPlaces = Mapper<PBRedeemPlace>().mapArray(apiResponse.parsedJson!) ?? []
        return redeemPlaces
    }
}

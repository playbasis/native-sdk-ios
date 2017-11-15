//
//  PBRedeemPlace.swift
//  Pods
//
//  Created by Médéric Petit on 8/25/2559 BE.
//
//

import ObjectMapper

open class PBRedeemPlace: PBModel {

    open var branches:[PBBranch]?
    open var merchant:PBMerchant?
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        branches <- map["branch"]
        merchant <- map["merchant"]
    }
    
    class func pbRedeemPlacesFromApiResponse(_ apiResponse:PBApiResponse) -> [PBRedeemPlace] {
        let redeemPlaces = Mapper<PBRedeemPlace>().mapArray(apiResponse.parsedJson!) ?? []
        return redeemPlaces
    }
}

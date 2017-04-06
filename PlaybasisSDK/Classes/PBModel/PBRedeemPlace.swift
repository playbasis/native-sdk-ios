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
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override open func mapping(_ map: Map) {
        super.mapping(map)
        branches <- map["branch"]
        merchant <- map["merchant"]
    }
    
    class func pbRedeemPlacesFromApiResponse(_ apiResponse:PBApiResponse) -> [PBRedeemPlace] {
        let redeemPlaces = Mapper<PBRedeemPlace>().mapArray(apiResponse.parsedJson!) ?? []
        return redeemPlaces
    }
}

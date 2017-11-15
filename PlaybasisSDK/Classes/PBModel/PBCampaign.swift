//
//  PBGameActiveCampaign.swift
//  Pods
//
//  Created by Mederic PETIT on 11/18/16.
//
//

import UIKit
import ObjectMapper

open class PBCampaign: PBModel {

    open var name:String! = ""
    open var image:String! = ""
    open var weight:Int! = 0
    open var dateStart:Date?
    open var dateEnd:Date?
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        image <- map["image"]
        weight <- map["weight"]
        dateStart <- (map["date_start"], ISO8601DateTransform())
        dateEnd <- (map["date_end"], ISO8601DateTransform())
    }
    
    init(apiResponse:PBApiResponse) {
        super.init()
        _ = Mapper<PBCampaign>().map(JSONObject: apiResponse.parsedJson!["result"] as Any, toObject: self)
    }
    
    class func pbCampaignsFromApiResponse(_ apiResponse:PBApiResponse) -> [PBCampaign] {
        return Mapper<PBCampaign>().mapArray(JSONObject: apiResponse.parsedJson!) ?? []
    }
    
    
}

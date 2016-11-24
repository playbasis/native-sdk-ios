//
//  PBGameActiveCampaign.swift
//  Pods
//
//  Created by Mederic PETIT on 11/18/16.
//
//

import UIKit
import ObjectMapper

public class PBCampaign: PBModel {

    public var name:String! = ""
    public var image:String! = ""
    public var weight:Int! = 0
    public var dateStart:NSDate?
    public var dateEnd:NSDate?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        name <- map["name"]
        image <- map["image"]
        weight <- map["weight"]
        dateStart <- (map["date_start"], ISO8601DateTransform())
        dateEnd <- (map["date_end"], ISO8601DateTransform())
    }
    
    init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBCampaign>().map(apiResponse.parsedJson!["result"], toObject: self)
    }
    
    class func pbCampaignsFromApiResponse(apiResponse:PBApiResponse) -> [PBCampaign] {
        return Mapper<PBCampaign>().mapArray(apiResponse.parsedJson!) ?? []
    }
    
    
}

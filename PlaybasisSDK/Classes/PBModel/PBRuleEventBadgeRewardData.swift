//
//  PBRuleEventBadgeRewardData.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/17/2559 BE.
//
//

import UIKit
import ObjectMapper

public class PBRuleEventBadgeRewardData: PBModel {
   
    public var badgeId:String! = ""
    public var imageURL:String! = ""
    public var name:String! = ""
    public var desc:String! = ""
    public var hint:String! = ""
    public var claim:Bool = false
    public var redeem:Bool = false
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        badgeId <- map["badge_id"]
        imageURL <- map["image"]
        name <- map["name"]
        desc <- map["description"]
        hint <- map["hint"]
        claim <- map["claim"]
        redeem <- map["redeem"]
    }
    
    public init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBRuleEventBadgeRewardData>().map(apiResponse.parsedJson!, toObject: self)
    }
    
    public class func pbRuleEventBadgeRewardDataFromApiResponse(apiResponse:PBApiResponse) -> [PBRuleEventBadgeRewardData] {
        var ruleEventBadgeRewardDataList:[PBRuleEventBadgeRewardData] = []
        ruleEventBadgeRewardDataList = Mapper<PBRuleEventBadgeRewardData>().mapArray(apiResponse.parsedJson!)!
        return ruleEventBadgeRewardDataList
    }
}

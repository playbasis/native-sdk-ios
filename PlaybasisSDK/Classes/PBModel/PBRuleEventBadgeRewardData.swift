//
//  PBRuleEventBadgeRewardData.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/17/2559 BE.
//
//

import UIKit
import ObjectMapper

open class PBRuleEventBadgeRewardData: PBModel {
   
    open var badgeId:String! = ""
    open var imageURL:String! = ""
    open var name:String! = ""
    open var desc:String! = ""
    open var hint:String! = ""
    open var claim:Bool = false
    open var redeem:Bool = false
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override open func mapping(_ map: Map) {
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
    
    open class func pbRuleEventBadgeRewardDataFromApiResponse(_ apiResponse:PBApiResponse) -> [PBRuleEventBadgeRewardData] {
        var ruleEventBadgeRewardDataList:[PBRuleEventBadgeRewardData] = []
        ruleEventBadgeRewardDataList = Mapper<PBRuleEventBadgeRewardData>().mapArray(apiResponse.parsedJson!)!
        return ruleEventBadgeRewardDataList
    }
}

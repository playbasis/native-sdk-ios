//
//  PBRuleEvent.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/16/2559 BE.
//
//

import UIKit
import ObjectMapper

public class PBRuleEvent: PBModel {
    
    public var eventType:String! = ""
    public var value:String! = ""
    public var index:Int = 0
    public var rewardRuleEventGoodsRewardData:PBRuleEventGoodsRewardData?
    public var rewardRuleEventBadgeRewardData:PBRuleEventBadgeRewardData?
    public var rewardType:RewardType?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        eventType <- map["event_type"]
        rewardType <- (map["reward_type"], EnumTransform<RewardType>())
        value <- map["value"]
        index <- map["index"]
        if rewardType != nil && rewardType == .Goods {
            rewardRuleEventGoodsRewardData <- map["reward_data"]
        }else if rewardType != nil && rewardType == .Badge {
            rewardRuleEventBadgeRewardData <- map["reward_data"]
        }
    }
    
    
    public  init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBRuleEvent>().map(apiResponse.parsedJson!, toObject: self)
    }
    
    public class func pbRuleEventFromApiResponse(apiResponse:PBApiResponse) -> [PBRuleEvent] {
        var ruleEventList:[PBRuleEvent] = []
        ruleEventList = Mapper<PBRuleEvent>().mapArray(apiResponse.parsedJson!)!
        return ruleEventList
    }

}

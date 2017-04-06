//
//  PBRuleEvent.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/16/2559 BE.
//
//

import UIKit
import ObjectMapper

open class PBRuleEvent: PBModel {
    
    open var eventType:String! = ""
    open var value:String! = ""
    open var index:Int = 0
    open var rewardRuleEventGoodsRewardData:PBRuleEventGoodsRewardData?
    open var rewardRuleEventBadgeRewardData:PBRuleEventBadgeRewardData?
    open var rewardType:String! = ""
    open var logId:String! = ""
    open var transactionId:String! = ""
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override open func mapping(_ map: Map) {
        super.mapping(map)
        eventType <- map["event_type"]
        rewardType <- (map["reward_type"])
        value <- map["value"]
        index <- map["index"]
        if rewardType != nil && rewardType == "goods" {
            rewardRuleEventGoodsRewardData <- map["reward_data"]
        }else if rewardType != nil && rewardType == "badge" {
            rewardRuleEventBadgeRewardData <- map["reward_data"]
        }
        logId <- map["log_id"]
        transactionId <- map["transaction_id"]
    }
    
    
    public  init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBRuleEvent>().map(apiResponse.parsedJson!, toObject: self)
    }
    
    open class func pbRuleEventFromApiResponse(_ apiResponse:PBApiResponse) -> [PBRuleEvent] {
        var ruleEventList:[PBRuleEvent] = []
        ruleEventList = Mapper<PBRuleEvent>().mapArray(apiResponse.parsedJson!)!
        return ruleEventList
    }
    
}

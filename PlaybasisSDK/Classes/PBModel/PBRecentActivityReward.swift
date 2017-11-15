//
//  PBRecentActivityReward.swift
//  Pods
//
//  Created by Médéric Petit on 9/20/2559 BE.
//
//

import UIKit
import ObjectMapper

open class PBRecentActivityReward: PBRecentActivity {
    
    open var message:String?
    open var rewardId:String?
    open var rewardName:String?
    open var value:Int?
    open var goodsId:String?
    open var questId:String?
    open var missionId:String?
    open var quizId:String?
    open var stringFilter:String?
    open var badge:PBBadge?
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        message <- map["message"]
        rewardId <- map["reward_id"]
        rewardName <- map["reward_name"]
        value <- map["value"]
        goodsId <- map["goods_id"]
        questId <- map["quest_id"]
        missionId <- map["mission_id"]
        quizId <- map["quiz_id"]
        stringFilter <- map["string_filter"]
        badge <- map["badge"]
        
    }
}

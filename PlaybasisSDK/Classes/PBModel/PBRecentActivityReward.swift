//
//  PBRecentActivityReward.swift
//  Pods
//
//  Created by Médéric Petit on 9/20/2559 BE.
//
//

import UIKit
import ObjectMapper

public class PBRecentActivityReward: PBRecentActivity {
    
    public var message:String?
    public var rewardId:String?
    public var rewardName:String?
    public var value:Int?
    public var goodsId:String?
    public var questId:String?
    public var missionId:String?
    public var quizId:String?
    public var stringFilter:String?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        message <- map["message"]
        rewardId <- map["reward_id"]
        rewardName <- map["reward_name"]
        value <- map["value"]
        goodsId <- map["goods_id"]
        questId <- map["quest_id"]
        missionId <- map["mission_id"]
        quizId <- map["quiz_id"]
        stringFilter <- map["string_filter"]
        
    }
}

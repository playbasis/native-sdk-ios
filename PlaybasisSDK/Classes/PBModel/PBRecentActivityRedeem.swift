//
//  PBRecentActivityRedeem.swift
//  Pods
//
//  Created by Médéric Petit on 9/20/2559 BE.
//
//

import UIKit
import ObjectMapper

open class PBRecentActivityRedeem: PBRecentActivity {
    
    open var actionLogId:String?
    open var message:String?
    open var rewardId:String?
    open var rewardName:String?
    open var value:Int?
    open var questId:String?
    open var missionId:String?
    open var quizId:String?
    open var goods:PBRewardData?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override open func mapping(_ map: Map) {
        super.mapping(map)
        actionLogId <- map["action_log_id"]
        message <- map["message"]
        rewardId <- map["reward_id"]
        rewardName <- map["reward_name"]
        value <- map["value"]
        questId <- map["quest_id"]
        missionId <- map["mission_id"]
        quizId <- map["quiz_id"]
        goods <- map["goods"]
    }

}

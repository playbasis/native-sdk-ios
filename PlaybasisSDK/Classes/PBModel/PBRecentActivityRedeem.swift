//
//  PBRecentActivityRedeem.swift
//  Pods
//
//  Created by Médéric Petit on 9/20/2559 BE.
//
//

import UIKit
import ObjectMapper

public class PBRecentActivityRedeem: PBRecentActivity {
    
    public var actionLogId:String?
    public var message:String?
    public var rewardId:String?
    public var rewardName:String?
    public var value:Int?
    public var questId:String?
    public var missionId:String?
    public var quizId:String?
    public var goods:PBRewardData?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
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

//
//  PBRuleEventMission.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/17/2559 BE.
//
//

import UIKit
import ObjectMapper

open class PBRuleEventMission: PBModel {
    
    open var missionId:String! = ""
    open var missionNumber:String! = ""
    open var name:String! = ""
    open var desc:String! = ""
    open var hint:String! = ""
    open var imageURL:String! = ""
    open var questId:String! = ""
    open var events:[PBRuleEvent] = []
    
    
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override open func mapping(_ map: Map) {
        super.mapping(map)
        missionId <- map["mission_id"]
        missionNumber <- map["mission_number"]
        name <- map["mission_name"]
        desc <- map["description"]
        hint <- map["hint"]
        imageURL <- map["image"]
        questId <- map["quest_id"]
        events <- map["events"]
        
    }
    
    
    public init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBRuleEventMission>().map(apiResponse.parsedJson!, toObject: self)
    }
    
    open class func pbRuleEventMissionFromApiResponse(_ apiResponse:PBApiResponse) -> [PBRuleEventMission] {
        var ruleEventMissionList:[PBRuleEventMission] = []
        ruleEventMissionList = Mapper<PBRuleEventMission>().mapArray(apiResponse.parsedJson!)!
        return ruleEventMissionList
    }
    
}

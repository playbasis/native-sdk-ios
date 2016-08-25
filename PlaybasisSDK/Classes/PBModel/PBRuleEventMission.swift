//
//  PBRuleEventMission.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/17/2559 BE.
//
//

import UIKit
import ObjectMapper

public class PBRuleEventMission: PBModel {
    
    public var missionId:String! = ""
    public var missionNumber:String! = ""
    public var name:String! = ""
    public var desc:String! = ""
    public var hint:String! = ""
    public var imageURL:String! = ""
    public var questId:String! = ""
    public var events:[PBRuleEvent] = []
    
    
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
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
    
    public class func pbRuleEventMissionFromApiResponse(apiResponse:PBApiResponse) -> [PBRuleEventMission] {
        var ruleEventMissionList:[PBRuleEventMission] = []
        ruleEventMissionList = Mapper<PBRuleEventMission>().mapArray(apiResponse.parsedJson!)!
        return ruleEventMissionList
    }
    
}

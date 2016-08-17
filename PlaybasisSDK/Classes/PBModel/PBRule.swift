//
//  PBRule.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/17/2559 BE.
//
//

import UIKit
import ObjectMapper

public class PBRule: PBModel {
    
    public var events:[PBRuleEvent] = []
    public var missions:[PBRuleEventMission] = []
    public var quests:[PBRuleEventQuest] = []
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public override func mapping(map: Map) {
        super.mapping(map)
        events <- map["events"]
        missions <- map["missions"]
        quests <- map["quests"]
    }
    
    
    public  init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBRule>().map(apiResponse.parsedJson!, toObject: self)
    }
    
    public class func pbRuleFromApiResponse(apiResponse:PBApiResponse) -> [PBRule] {
        var ruleList:[PBRule] = []
        ruleList = Mapper<PBRule>().mapArray(apiResponse.parsedJson!)!
        return ruleList
    }
}

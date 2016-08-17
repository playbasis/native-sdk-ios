//
//  PBRuleEventQuest.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/17/2559 BE.
//
//

import UIKit
import ObjectMapper

public class PBRuleEventQuest: PBModel {
    
    
    public var questName:String! = ""
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
    }
    
    
    public  init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBRuleEventQuest>().map(apiResponse.parsedJson!, toObject: self)
    }
    
    public class func pbRuleEventQuestFromApiResponse(apiResponse:PBApiResponse) -> [PBRuleEventQuest] {
        var ruleEventQuestList:[PBRuleEventQuest] = []
        ruleEventQuestList = Mapper<PBRuleEventQuest>().mapArray(apiResponse.parsedJson!)!
        return ruleEventQuestList
    }
    

}

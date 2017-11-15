//
//  PBRuleEventQuest.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/17/2559 BE.
//
//

import UIKit
import ObjectMapper

open class PBRuleEventQuest: PBModel {
    
    
    open var questName:String! = ""
    open var desc:String! = ""
    open var hint:String! = ""
    open var imageURL:String! = ""
    open var questId:String! = ""
    open var events:[PBRuleEvent] = []

    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
    }
    
    
    public  init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBRuleEventQuest>().map(JSONObject: apiResponse.parsedJson!, toObject: self)
    }
    
    open class func pbRuleEventQuestFromApiResponse(_ apiResponse:PBApiResponse) -> [PBRuleEventQuest] {
        var ruleEventQuestList:[PBRuleEventQuest] = []
        ruleEventQuestList = Mapper<PBRuleEventQuest>().mapArray(JSONObject: apiResponse.parsedJson!)!
        return ruleEventQuestList
    }
    

}

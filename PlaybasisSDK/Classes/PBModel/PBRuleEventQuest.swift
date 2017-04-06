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
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override open func mapping(_ map: Map) {
        super.mapping(map)
    }
    
    
    public  init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBRuleEventQuest>().map(apiResponse.parsedJson!, toObject: self)
    }
    
    open class func pbRuleEventQuestFromApiResponse(_ apiResponse:PBApiResponse) -> [PBRuleEventQuest] {
        var ruleEventQuestList:[PBRuleEventQuest] = []
        ruleEventQuestList = Mapper<PBRuleEventQuest>().mapArray(apiResponse.parsedJson!)!
        return ruleEventQuestList
    }
    

}

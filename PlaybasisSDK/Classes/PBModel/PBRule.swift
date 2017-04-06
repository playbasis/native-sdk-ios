//
//  PBRule.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/17/2559 BE.
//
//

import UIKit
import ObjectMapper

open class PBRule: PBModel {
    
    open var events:[PBRuleEvent] = []
    open var missions:[PBRuleEventMission] = []
    open var quests:[PBRuleEventQuest] = []
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    open override func mapping(_ map: Map) {
        super.mapping(map)
        events <- map["events"]
        missions <- map["missions"]
        quests <- map["quests"]
    }
    
    
    public  init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBRule>().map(apiResponse.parsedJson!, toObject: self)
    }
    
    open class func pbRuleFromApiResponse(_ apiResponse:PBApiResponse) -> [PBRule] {
        var ruleList:[PBRule] = []
        ruleList = Mapper<PBRule>().mapArray(apiResponse.parsedJson!)!
        return ruleList
    }
}



open class PBGameRule: PBModel {
    
    open var name:String! = ""
    open var desc:String! = ""
    open var tags:String! = ""
    open var jigsawSet:[PBGameRuleJigsawSet] = []
    open var activeStatus:Bool = true
    open var action:Bool = false
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    open override func mapping(_ map: Map) {
        super.mapping(map)
        name <- map["name"]
        desc <- map["description"]
        tags <- map["tags"]
        jigsawSet <- map["jigsaw_set"]
        activeStatus <- map["active_status"]
        action <- map["action"]
        
    }
    
    public init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBGameRule>().map(apiResponse.parsedJson!, toObject: self)
    }
    
    open class func pbGameRuleFromApiResponse(_ apiResponse:PBApiResponse) -> [PBGameRule] {
        return Mapper<PBGameRule>().mapArray(apiResponse.parsedJson!) ?? []
    }
}

open class PBGameRuleJigsawSet: PBModel {
    
    open var name:String! = ""
    open var desc:String! = ""
    open var specificId:String! = ""
    open var category:String = ""
    open var sortOrder:Int! = 1
    open var jigsawIndex:String! = ""
    open var dataSet:[PBGameRuleDataSet] = []
    open var configAction:PBGameRuleConfigAction?
    open var configCondition:PBGameRuleConfigCondition?
    open var configGroup:PBGameRuleConfigGroup?
    open var configReward:PBGameRuleConfigGroupContainer?
    
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    open override func mapping(_ map: Map) {
        super.mapping(map)
        name <- map["name"]
        desc <- map["description"]
        specificId <- map["specific_id"]
        category <- map["category"]
        sortOrder <- map["sort_order"]
        jigsawIndex <- map["jigsaw_index"]
        dataSet <- map["dataSet"]
        switch category {
        case "ACTION":
            configAction <- map["config"]
        case "CONDITION":
            configCondition <- map["config"]
        case "GROUP":
            configGroup <- map["config"]
        case "REWARD":
            configReward <- map["config"]
        default:
            break
        }
        
    }
    
    public init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBGameRuleJigsawSet>().map(apiResponse.parsedJson!, toObject: self)
    }
    
    open class func pbGameRuleFromApiResponse(_ apiResponse:PBApiResponse) -> [PBGameRuleJigsawSet] {
        return Mapper<PBGameRuleJigsawSet>().mapArray(apiResponse.parsedJson!) ?? []
    }
}


open class PBGameRuleDataSet: PBModel {
    
    open var fieldType:String! = ""
    open var sortOrder:String! = ""
    open var paramName:String! = ""
    open var label:String! = ""
    open var placeHolder:String! = ""
    open var value:[PBGameRuleJigsawSet] = []
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    open override func mapping(_ map: Map) {
        super.mapping(map)
        fieldType <- map["field_type"]
        sortOrder <- map["sort_order"]
        paramName <- map["param_name"]
        label <- map["label"]
        placeHolder <- map["placeholder"]
        value <- map["value"]
    }
    
}

open class PBGameRuleConfigAction:PBModel {
    
    open var actionId:String? = ""
    open var actionName:String? = ""
    open var customParam:[String:AnyObject]?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    open override func mapping(_ map: Map) {
        super.mapping(map)
        actionId <- map["action_id"]
        actionName <- map["action_name"]
        customParam = map.JSONDictionary
    }
    
}

open class PBGameRuleConfigCondition:PBModel {
    
    open var paramName:String! = ""
    open var paramOperation:String! = ""
    open var paramValue:String! = ""
    open var conditionId:String! = ""
    open var groupContainer:[PBGameRuleConfigGroupContainer] = []
    open var customParam:[String:AnyObject]?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    open override func mapping(_ map: Map) {
        super.mapping(map)
        paramName <- map["param_name"]
        paramOperation <- map["param_operation"]
        paramValue <- map["param_value"]
        conditionId <- map["condition_id"]
        groupContainer <- map["group_container"]
        customParam = map.JSONDictionary
    }
    
}

open class PBGameRuleConfigGroup:PBModel {
    
    open var groupContainer:[PBGameRuleConfigGroupContainer]? = []
    open var groupId:String? = ""
    open var customParam:[String:AnyObject]?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    open override func mapping(_ map: Map) {
        super.mapping(map)
        groupContainer <- map["group_container"]
        groupId <- map["group_id"]
        customParam = map.JSONDictionary
    }
    
}

open class PBGameRuleConfigGroupContainer:PBModel {
    
    open var rewardName:String! = ""
    open var itemId:String! = ""
    open var quantity:String! = ""
    open var customLog:String! = ""
    open var weight:String! = ""
    open var rewardId:String! = ""
    open var data:PBRewardData?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    open override func mapping(_ map: Map) {
        super.mapping(map)
        rewardName <- map["reward_name"]
        itemId <- map["item_id"]
        quantity <- map["quantity"]
        customLog <- map["custom_log"]
        weight <- map["weight"]
        rewardId <- map["reward_id"]
        data <- map["data"]
    }
    
}


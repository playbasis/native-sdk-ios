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



public class PBGameRule: PBModel {
    
    public var name:String! = ""
    public var desc:String! = ""
    public var tags:String! = ""
    public var jigsawSet:[PBGameRuleJigsawSet] = []
    public var activeStatus:Bool = true
    public var action:Bool = false
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public override func mapping(map: Map) {
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
    
    public class func pbGameRuleFromApiResponse(apiResponse:PBApiResponse) -> [PBGameRule] {
        return Mapper<PBGameRule>().mapArray(apiResponse.parsedJson!) ?? []
    }
}

public class PBGameRuleJigsawSet: PBModel {
    
    public var name:String! = ""
    public var desc:String! = ""
    public var specificId:String! = ""
    public var category:String = ""
    public var sortOrder:Int! = 1
    public var jigsawIndex:String! = ""
    public var dataSet:[PBGameRuleDataSet] = []
    public var configAction:PBGameRuleConfigAction?
    public var configCondition:PBGameRuleConfigCondition?
    public var configGroup:PBGameRuleConfigGroup?
    public var configReward:PBGameRuleConfigGroupContainer?
    
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public override func mapping(map: Map) {
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
    
    public class func pbGameRuleFromApiResponse(apiResponse:PBApiResponse) -> [PBGameRuleJigsawSet] {
        return Mapper<PBGameRuleJigsawSet>().mapArray(apiResponse.parsedJson!) ?? []
    }
}


public class PBGameRuleDataSet: PBModel {
    
    public var fieldType:String! = ""
    public var sortOrder:String! = ""
    public var paramName:String! = ""
    public var label:String! = ""
    public var placeHolder:String! = ""
    public var value:[PBGameRuleJigsawSet] = []
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public override func mapping(map: Map) {
        super.mapping(map)
        fieldType <- map["field_type"]
        sortOrder <- map["sort_order"]
        paramName <- map["param_name"]
        label <- map["label"]
        placeHolder <- map["placeholder"]
        value <- map["value"]
    }
    
}

public class PBGameRuleConfigAction:PBModel {
    
    public var actionId:String? = ""
    public var actionName:String? = ""
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public override func mapping(map: Map) {
        super.mapping(map)
        actionId <- map["action_id"]
        actionName <- map["action_name"]
    }
    
}

public class PBGameRuleConfigCondition:PBModel {
    
    public var paramName:String! = ""
    public var paramOperation:String! = ""
    public var paramValue:String! = ""
    public var conditionId:String! = ""
    public var groupContainer:[PBGameRuleConfigGroupContainer] = []
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public override func mapping(map: Map) {
        super.mapping(map)
        paramName <- map["param_name"]
        paramOperation <- map["param_operation"]
        paramValue <- map["param_value"]
        conditionId <- map["condition_id"]
        groupContainer <- map["group_container"]
    }
    
}

public class PBGameRuleConfigGroup:PBModel {
    
    public var groupContainer:[PBGameRuleConfigGroupContainer]? = []
    public var groupId:String? = ""
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public override func mapping(map: Map) {
        super.mapping(map)
        groupContainer <- map["group_container"]
        groupId <- map["group_id"]
    }
    
}

public class PBGameRuleConfigGroupContainer:PBModel {
    
    public var rewardName:String! = ""
    public var itemId:String! = ""
    public var quantity:String! = ""
    public var customLog:String! = ""
    public var weight:String! = ""
    public var rewardId:String! = ""
    public var data:PBRewardData?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public override func mapping(map: Map) {
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


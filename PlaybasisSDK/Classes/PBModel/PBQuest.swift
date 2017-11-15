//
//  PBQuest.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/20/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper


open class PBQuest: PBModel {
    
    open var name:String! = ""
    open var desc:String! = ""
    open var hint:String! = ""
    open var imageURL:String! = ""
    open var clientId:String?
    open var siteId:String?
    open var questId:String?
    open var missionOrder:Bool?
    open var sortOrder:Int?
    open var dateAdded:Date?
    open var dateModified:Date?
    open var tags:String?
    open var rewards:[PBReward] = []
    open var mission:[PBMission] = []
    open var status:Bool = false
    open var feedbacks:String?
    open var organizeId:String?
    open var organizeRole:String?
    open var condition:[PBCondition] = []
    open var playerStatus:String! = ""
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBQuest>().map(JSONObject: apiResponse.parsedJson!["quests"], toObject: self)
    }
    
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["quest_name"]
        desc <- map["description"]
        hint <- map["hint"]
        imageURL <- map["image"]
        status <- map["status"]
        hint <- map["hint"]
        clientId <- map["client_id"]
        siteId <- map["site_id"]
        questId <- map["quest_id"]
        missionOrder <- map["mission_order"]
        sortOrder <- map["sort_order"]
        dateAdded <- (map["date_added"], ISO8601DateTransform())
        dateModified <- (map["date_modified"], ISO8601DateTransform())
        rewards <- map["rewards"]
        mission <- map["missions"]
    
        condition <- map["condition"]
        feedbacks <- map["feedbacks"]
        organizeId <- map["organize_id"]
        organizeRole <- map["organize_role"]
        playerStatus <- map["player_status"]
    }
    
    class func pbQuestFromApiResponse(_ apiResponse:PBApiResponse) -> [PBQuest] {
        var qustList:[PBQuest] = []
        qustList = Mapper<PBQuest>().mapArray(JSONObject: apiResponse.parsedJson!["quests"])!
        return qustList
    }

}

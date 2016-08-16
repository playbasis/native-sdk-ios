//
//  PBQuest.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/20/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper


class PBQuest: PBModel {
    
    var name:String! = ""
    var desc:String! = ""
    var hint:String! = ""
    var imageURL:String! = ""
    var clientId:String?
    var siteId:String?
    var questId:String?
    var missionOrder:Bool?
    var sortOrder:Int?
    var dateAdded:NSDate?
    var dateModified:NSDate?
    var tags:String?
    var rewards:[PBReward] = []
    var mission:[PBMission] = []
    var status:Bool = false
    var feedbacks:String?
    var organizeId:String?
    var organizeRole:String?
    var condition:[PBCondition] = []
    var playerStatus:String! = ""
    
    override init() {
        super.init()
    }
    
    init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBQuest>().map(apiResponse.parsedJson!["quests"], toObject: self)
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    
    override func mapping(map: Map) {
        super.mapping(map)
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
        dateAdded <- map["date_added"]
        dateModified <- map["date_modified"]
        rewards <- map["rewards"]
        mission <- map["missions"]
    
        condition <- map["condition"]
        feedbacks <- map["feedbacks"]
        organizeId <- map["organize_id"]
        organizeRole <- map["organize_role"]
        playerStatus <- map["player_status"]
    }
    
    class func pbQuestFromApiResponse(apiResponse:PBApiResponse) -> [PBQuest] {
        var qustList:[PBQuest] = []
        qustList = Mapper<PBQuest>().mapArray(apiResponse.parsedJson!["quests"])!
        return qustList
    }

}

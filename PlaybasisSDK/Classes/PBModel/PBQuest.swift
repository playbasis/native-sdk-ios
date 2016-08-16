//
//  PBQuest.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/20/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper


public class PBQuest: PBModel {
    
    public var name:String! = ""
    public var desc:String! = ""
    public var hint:String! = ""
    public var imageURL:String! = ""
    public var clientId:String?
    public var siteId:String?
    public var questId:String?
    public var missionOrder:Bool?
    public var sortOrder:Int?
    public var dateAdded:NSDate?
    public var dateModified:NSDate?
    public var tags:String?
    public var rewards:[PBReward] = []
    public var mission:[PBMission] = []
    public var status:Bool = false
    public var feedbacks:String?
    public var organizeId:String?
    public var organizeRole:String?
    public var condition:[PBCondition] = []
    public var playerStatus:String! = ""
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBQuest>().map(apiResponse.parsedJson!["quests"], toObject: self)
    }
    
    
    override public func mapping(map: Map) {
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

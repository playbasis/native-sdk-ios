//
//  PBLeaderBoard.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/24/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBLeaderBoard: PBModel {
    
    open var dateCompleted:Date?
    open var dateJoined:Date?
    open var status:String! = ""
    open var current:Int! = 0
    open var goal:Int! = 0
    open var player:PBPlayerBasic?
    open var rank:Int! = 0
    
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        self.dateCompleted <- (map["date_completed"],ISO8601DateTransform())
        self.dateJoined <- (map["date_join"], ISO8601DateTransform())
        self.status <- map["status"]
        self.current <- map["current"]
        self.goal <- map["goal"]
        self.player <- map["player"]
        self.rank <- map["rank"]
 
    }
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    init(apiResponse:PBApiResponse) {
        super.init()
        _ = Mapper<PBLeaderBoard>().map(JSONObject: apiResponse.parsedJson!["player_data"] as Any, toObject: self)
    }
    
    class func pbLeaderBoardDataFromApiResponse(_ apiResponse:PBApiResponse) -> (leaderBoardList:[PBLeaderBoard], playerData:PBLeaderBoard?) {
        var pbLeaderBoardList:[PBLeaderBoard] = []
        pbLeaderBoardList = Mapper<PBLeaderBoard>().mapArray(JSONObject: apiResponse.parsedJson!["result"] as Any)!
        if let playerDataJson = apiResponse.parsedJson!["player_data"], let playerData:PBLeaderBoard = Mapper<PBLeaderBoard>().map(JSONObject: playerDataJson) {
            return (leaderBoardList:pbLeaderBoardList, playerData:playerData)
        }
        else {
            return (leaderBoardList:pbLeaderBoardList, playerData:nil)
        }
    }
}

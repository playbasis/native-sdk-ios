//
//  PBLeaderBoard.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/24/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBLeaderBoard: PBModel {
    
    var dateCompleted:NSDate?
    var dateJoined:NSDate?
    var status:String! = ""
    var current:Int! = 0
    var goal:Int! = 0
    var player:PBPlayerBasic?
    var rank:Int! = 0
    
    
    override public func mapping(map: Map) {
        super.mapping(map)
        self.dateCompleted <- (map["date_completed"],ISO8601DateTransform())
        self.dateJoined <- (map["date_join"], ISO8601DateTransform())
        self.status <- map["status"]
        self.current <- map["current"]
        self.goal <- map["goal"]
        self.player <- map["player"]
        self.rank <- map["rank"]
 
    }
    
    override init() {
        super.init()
    }
    
    init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBLeaderBoard>().map(apiResponse.parsedJson!["player_data"], toObject: self)
    }
    
    required public init?(_ map: Map) {
         super.init(map)
    }
    
    
    class func pbLeaderBoardDataFromApiResponse(apiResponse:PBApiResponse) -> (leaderBoardList:[PBLeaderBoard], playerData:PBLeaderBoard?) {
        var pbLeaderBoardList:[PBLeaderBoard] = []
        pbLeaderBoardList = Mapper<PBLeaderBoard>().mapArray(apiResponse.parsedJson!["result"])!
        if let playerDataJson = apiResponse.parsedJson!["player_data"], let playerData:PBLeaderBoard = Mapper<PBLeaderBoard>().map(playerDataJson) {
            return (leaderBoardList:pbLeaderBoardList, playerData:playerData)
        }
        else {
            return (leaderBoardList:pbLeaderBoardList, playerData:nil)
        }
    }
}

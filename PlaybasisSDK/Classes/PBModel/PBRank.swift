//
//  PBRank.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 8/15/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBRank: PBModel{
    
    var playerId:String! = ""
    var imageURL:String! = ""
    var firstName:String! = ""
    var lastName:String! = ""
    var point:Int = 0
    var gold:Int = 0
    var token:Int = 0
    
    override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }

    override public func mapping(map: Map) {
        super.mapping(map)
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        imageURL <- map["image"]
        playerId <- map["player_id"]
        point <- map["point"]
        gold <- map["gold"]
        token <- map["token"]
    }
    
    func getFullName() -> String {
      return "\(firstName)  \(lastName)"
    }
    
    class func pbrankFromApiResponse(apiResponse:PBApiResponse) -> [PBRank] {
        var rankList:[PBRank] = []
        rankList = Mapper<PBRank>().mapArray(apiResponse.parsedJson!)!
        return rankList
    }
}

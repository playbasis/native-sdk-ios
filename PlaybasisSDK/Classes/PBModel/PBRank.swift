//
//  PBRank.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 8/15/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBRank: PBModel{
    
    open var playerId:String! = ""
    open var imageURL:String! = ""
    open var firstName:String! = ""
    open var lastName:String! = ""
    open var point:Int = 0
    open var gold:Int = 0
    open var token:Int = 0
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }

    override open func mapping(map: Map) {
        super.mapping(map: map)
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        imageURL <- map["image"]
        playerId <- map["player_id"]
        point <- map["point"]
        gold <- map["gold"]
        token <- map["token"]
    }
    
    open func getFullName() -> String {
        if self.firstName != nil && self.lastName != nil {
            return "\(firstName)  \(lastName)"
        }else if self.firstName != nil {
            return firstName
        }
        return ""
    }
    
    class func pbrankFromApiResponse(_ apiResponse:PBApiResponse) -> [PBRank] {
        var rankList:[PBRank] = []
        rankList = Mapper<PBRank>().mapArray(apiResponse.parsedJson!)!
        return rankList
    }
}

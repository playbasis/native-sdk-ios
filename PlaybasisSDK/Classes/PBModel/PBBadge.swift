//
//  PBBadge.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/17/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBBadge: PBModel {

    public var imageURL:String! = ""
    public var name:String! = ""
    public var desc:String! = ""
    public var badgeId:String! = ""
    public var hint:String! = ""
    public var sponsor:Bool! = false
    public var amount:Int! = 0
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public override func mapping(map: Map) {
        name <- map["name"]
        desc <- map["description"]
        badgeId <- map["badge_id"]
        imageURL <- map["image"]
        sponsor <- map["sponsor"]
        hint <- map["hint"]
        amount <- map["amount"]
    }
    
    class func pbBadgesFromDicArray(badgeArray:[AnyObject]) -> [PBBadge] {
        return Mapper<PBBadge>().mapArray(badgeArray) ?? []
    }
    
    class func pbBadgeFromApiResponse(apiResponse:PBApiResponse) -> [PBBadge] {
        var badges:[PBBadge] = []
        badges = Mapper<PBBadge>().mapArray(apiResponse.parsedJson!)!
        return badges
    }
    

    
    
}

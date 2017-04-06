//
//  PBBadge.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/17/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBBadge: PBModel {

    open var imageURL:String! = ""
    open var name:String! = ""
    open var desc:String! = ""
    open var badgeId:String! = ""
    open var hint:String! = ""
    open var sponsor:Bool! = false
    open var amount:Int! = 0
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    open override func mapping(map: Map) {
        name <- map["name"]
        desc <- map["description"]
        badgeId <- map["badge_id"]
        imageURL <- map["image"]
        sponsor <- map["sponsor"]
        hint <- map["hint"]
        amount <- map["amount"]
    }
    
    class func pbBadgesFromDicArray(_ badgeArray:[AnyObject]) -> [PBBadge] {
        return Mapper<PBBadge>().mapArray(JSONObject: badgeArray) ?? []
    }
    
    class func pbBadgeFromApiResponse(_ apiResponse:PBApiResponse) -> [PBBadge] {
        var badges:[PBBadge] = []
        badges = Mapper<PBBadge>().mapArray(JSONObject: apiResponse.parsedJson!)!
        return badges
    }
    

    
    
}

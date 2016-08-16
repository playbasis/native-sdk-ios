//
//  PBBadge.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/17/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBBadge: NSObject,Mappable {

    var imageURL:String! = ""
    var name:String! = ""
    var desc:String! = ""
    var badgeId:String! = ""
    var hint:String! = ""
    var sponsor:Bool! = false
    var amount:Int! = 0
    
    override init() {
        super.init()
    }
    
    required public init?(_ map: Map){
    }
    
    public func mapping(map: Map) {
        name <- map["name"]
        desc <- map["description"]
        badgeId <- map["badge_id"]
        imageURL <- map["image"]
        sponsor <- map["sponsor"]
        hint <- map["hint"]
        amount <- map["amount"]
    }
    
    class func pbBadgeFromApiResponse(apiResponse:PBApiResponse) -> [PBBadge] {
        var badges:[PBBadge] = []
        badges = Mapper<PBBadge>().mapArray(apiResponse.parsedJson!)!
        return badges
    }
    

    
    
}

//
//  PBPoint.swift
//  Playbook
//
//  Created by Médéric Petit on 7/28/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

class PBPoint: PBModel {

    var value:Int! = 0
    var rewardName:String! = ""
    var rewardId:String! = ""
    
    override func mapping(map: Map) {
        super.mapping(map)
        value <- map["value"]
        rewardName <- map["reward_name"]
        rewardId <- map["reward_id"]
    }
    
    
    class func pbPointFromPointsApiResponse(apiResponse:PBApiResponse) -> [PBPoint] {
        var points:[PBPoint] = []
        points = Mapper<PBPoint>().mapArray(apiResponse.parsedJson!["points"])!
        return points
    }
    
}

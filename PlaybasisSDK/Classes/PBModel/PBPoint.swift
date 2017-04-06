//
//  PBPoint.swift
//  Playbook
//
//  Created by Médéric Petit on 7/28/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBPoint: PBModel {

    open var value:Int! = 0
    open var rewardName:String! = ""
    open var rewardId:String! = ""
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override open func mapping(_ map: Map) {
        super.mapping(map)
        value <- map["value"]
        rewardName <- map["reward_name"]
        rewardId <- map["reward_id"]
    }
    
    
    class func pbPointFromPointsApiResponse(_ apiResponse:PBApiResponse) -> [PBPoint] {
        var points:[PBPoint] = []
        points = Mapper<PBPoint>().mapArray(apiResponse.parsedJson!["points"])!
        return points
    }
    
}

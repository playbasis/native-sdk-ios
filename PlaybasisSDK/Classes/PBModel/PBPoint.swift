//
//  PBPoint.swift
//  Playbook
//
//  Created by Médéric Petit on 7/28/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBPoint: PBModel {

    public var value:Int! = 0
    public var rewardName:String! = ""
    public var rewardId:String! = ""
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
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

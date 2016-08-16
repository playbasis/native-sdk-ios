//
//  PBReward.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/20/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public enum RewardType:String {
    case Goods = "GOODS"
    case Badge = "BADGE"
}


public class PBReward: PBModel {
    
    var value:String?
    var type:RewardType = .Goods
    var rewardId:String?
    var rewardData:PBRewardData?
    
    override public func mapping(map: Map) {
        super.mapping(map)
        value <- map["reward_value"]
        type <- (map["reward_type"], EnumTransform<RewardType>())
        rewardId <- map["reward_id"]
        rewardData <- map["reward_data"]
    }
    
    
    class func pbRewardFromGoodsApiResponse(apiResponse:PBApiResponse) -> [PBReward] {
        var goods:[PBReward] = []
        goods = Mapper<PBReward>().mapArray(apiResponse.parsedJson!["goods"])!
        return goods
    }

}




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


open class PBReward: PBModel {
    
    open var value:String?
    open var type:RewardType = .Goods
    open var rewardId:String?
    open var rewardData:PBRewardData?
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        value <- map["reward_value"]
        type <- (map["reward_type"], EnumTransform<RewardType>())
        rewardId <- map["reward_id"]
        rewardData <- map["reward_data"]
    }
    
    
    class func pbRewardFromGoodsApiResponse(_ apiResponse:PBApiResponse) -> [PBReward] {
        var goods:[PBReward] = []
        goods = Mapper<PBReward>().mapArray(JSONObject: apiResponse.parsedJson!["goods"] as Any)!
        return goods
    }

}




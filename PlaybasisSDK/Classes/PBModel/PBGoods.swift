//
//  PBGoods.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 7/7/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public enum PBGoodStatus:String {
    case Active = "active"
    case All = "all"
    case Expired = "expired"
    case Used = "used"
}

open class PBGoods: PBModel {
    
    open var good:PBRewardData?
    open var amount:Int! = 0
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        self.good <- map["goods"]
        self.amount <- map["amount"]
    }

    
    init(apiResponse:PBApiResponse) {
        super.init()
        _ = Mapper<PBGoods>().map(JSONObject: apiResponse.parsedJson!, toObject: self)
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    public override init() {
        super.init()
    }

}

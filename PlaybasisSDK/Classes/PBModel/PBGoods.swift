//
//  PBGoods.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 7/7/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBGoods: PBModel {
    
    var good:PBRewardData?
    var amount:Int! = 0
    
    override public func mapping(map: Map) {
        super.mapping(map)
        self.good <- map["goods"]
        self.amount <- map["amount"]
    }

    
    init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBGoods>().map(apiResponse.parsedJson!, toObject: self)
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }

}

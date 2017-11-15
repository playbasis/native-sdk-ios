//
//  PBRewardData.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/21/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBRedeem: PBModel {
    open var point:PBRedeemPoint!
    open var custom:[PBRedeemCustom]! = []
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        point <- map["point"]
        custom <- map["custom"]
    }
}

open class PBRedeemPoint:PBModel {
    open var pointValue:Int! = 0
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        pointValue <- map["point_value"]
    }
}

open class PBRedeemCustom:PBModel {
    open var customId:String?
    open var customName:String?
    open var customValue:Int! = 0
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        customId <- map["custom_id"]
        customName <- map["custom_name"]
        customValue <- map["custom_value"]
    }
}

open class PBRewardData: PBModel {
    
    open var rewardDataId:String?
    open var desc:String! = ""
    open var imageURL:String! = ""
    open var status:Bool = false
    open var deleted:Bool = false
    open var sponsor:Bool = false
    open var tags:[String]?
    open var dateStart:Date?
    open var dateExpire:Date?
    open var dateAdded:Date?
    open var dateModified:Date?
    open var name:String! = ""
    open var code:String! = ""
    open var clientId:String?
    open var siteId:String?
    open var goodsId:String?
    open var group:String?
    open var amount:Int = 0
    open var quantity:Int = 0
    open var perUser:Int = 0
    open var sortOrder:Int = 0
    open var languageId:Int = 0
    
    open var redeem:PBRedeem!
  
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        rewardDataId <- map["_id"]
        desc <- map["description"]
        quantity <- map["quantity"]
        perUser <- map["per_user"]
        imageURL <- map["image"]
        status <- map["status"]
        deleted <- map["deleted"]
        sponsor <- map["sponsor"]
        sortOrder <- map["sort_order"]
        languageId <- map["language_id"]
        sortOrder <- map["sort_order"]
        tags <- map["tags"]
        dateStart <- (map["date_start"], ISO8601DateTransform())
        dateExpire <- (map["date_expire"], ISO8601DateTransform())
        dateAdded <- (map["date_added"], ISO8601DateTransform())
        dateModified <- (map["date_modified"], ISO8601DateTransform())
        name <- map["name"]
        code <- map["code"]
        clientId <- map["client_id"]
        siteId <- map["site_id"]
        goodsId <- map["goods_id"]
        group <- map["group"]
        amount <- map["amount"]
  
        redeem <- map["redeem"]
    }
    
    class func pbGoodsFromApiResponse(_ apiResponse:PBApiResponse) -> [PBRewardData] {
        var goods:[PBRewardData] = []
        goods = Mapper<PBRewardData>().mapArray(apiResponse.parsedJson!["goods_list"])!
        return goods
    }
    
    class func pbSmallGoodsFromApiResponse(_ apiResponse:PBApiResponse) -> [PBRewardData] {
        var goods:[PBRewardData] = []
        goods = Mapper<PBRewardData>().mapArray(apiResponse.parsedJson!["goods"])!
        return goods
    }
}

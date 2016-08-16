//
//  PBRewardData.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/21/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

class PBRedeem: PBModel {
    var point:PBRedeemPoint!
    var custom:[PBRedeemCustom]! = []
    
    override func mapping(map: Map) {
        super.mapping(map)
        point <- map["point"]
        custom <- map["custom"]
    }
}

class PBRedeemPoint:PBModel {
    var pointValue:Int! = 0
    
    override func mapping(map: Map) {
        super.mapping(map)
        pointValue <- map["point_value"]
    }
}

class PBRedeemCustom:PBModel {
    var customId:String?
    var customName:String?
    var customValue:Int! = 0
    
    override func mapping(map: Map) {
        super.mapping(map)
        customId <- map["custom_id"]
        customName <- map["custom_name"]
        customValue <- map["custom_value"]
    }
}

class PBRewardData: PBModel {
    
    var rewardDataId:String?
    var desc:String! = ""
    var quantity:Int?
    var perUser:Int?
    var imageURL:String! = ""
    var status:Bool = false
    var deleted:Bool = false
    var sponsor:Bool = false
    var sortOrder:Int?
    var languageId:Int?
    var tags:[String]?
    var dateStart:NSDate?
    var dateExpire:NSDate?
    var dateAdded:NSDate?
    var dateModified:NSDate?
    var name:String! = ""
    var code:String! = ""
    var clientId:String?
    var siteId:String?
    var goodsId:String?
    var group:String?
    var amount:Int! = 0
    var redeem:PBRedeem!
  
    
    
    
    override func mapping(map: Map) {
        super.mapping(map)
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
        dateStart <- map["date_start"]
        dateExpire <- map["date_expire"]
        dateAdded <- map["date_added"]
        dateModified <- map["date_modified"]
        
        name <- map["name"]
        code <- map["code"]
        clientId <- map["client_id"]
        siteId <- map["site_id"]
        goodsId <- map["goods_id"]
        group <- map["group"]
        amount <- map["amount"]
  
        redeem <- map["redeem"]
    }
    
    class func pbGoodsFromApiResponse(apiResponse:PBApiResponse) -> [PBRewardData] {
        var goods:[PBRewardData] = []
        goods = Mapper<PBRewardData>().mapArray(apiResponse.parsedJson!["goods_list"])!
        return goods
    }
    
    class func pbSmallGoodsFromApiResponse(apiResponse:PBApiResponse) -> [PBRewardData] {
        var goods:[PBRewardData] = []
        goods = Mapper<PBRewardData>().mapArray(apiResponse.parsedJson!["goods"])!
        return goods
    }
}

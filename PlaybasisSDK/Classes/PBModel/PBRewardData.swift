//
//  PBRewardData.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/21/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBRedeem: PBModel {
    public var point:PBRedeemPoint!
    public var custom:[PBRedeemCustom]! = []
    
    override public func mapping(map: Map) {
        super.mapping(map)
        point <- map["point"]
        custom <- map["custom"]
    }
}

public class PBRedeemPoint:PBModel {
    public var pointValue:Int! = 0
    
    override public func mapping(map: Map) {
        super.mapping(map)
        pointValue <- map["point_value"]
    }
}

public class PBRedeemCustom:PBModel {
    public var customId:String?
    public var customName:String?
    public var customValue:Int! = 0
    
    override public func mapping(map: Map) {
        super.mapping(map)
        customId <- map["custom_id"]
        customName <- map["custom_name"]
        customValue <- map["custom_value"]
    }
}

public class PBRewardData: PBModel {
    
    public var rewardDataId:String?
    public var desc:String! = ""
    public var quantity:Int?
    public var perUser:Int?
    public var imageURL:String! = ""
    public var status:Bool = false
    public var deleted:Bool = false
    public var sponsor:Bool = false
    public var sortOrder:Int?
    public var languageId:Int?
    public var tags:[String]?
    public var dateStart:NSDate?
    public var dateExpire:NSDate?
    public var dateAdded:NSDate?
    public var dateModified:NSDate?
    public var name:String! = ""
    public var code:String! = ""
    public var clientId:String?
    public var siteId:String?
    public var goodsId:String?
    public var group:String?
    public var amount:Int! = 0
    public var redeem:PBRedeem!
  
    
    
    
    override public func mapping(map: Map) {
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

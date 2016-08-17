//
//  PBRuleEventGoodsRewardData.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/16/2559 BE.
//
//

import UIKit
import ObjectMapper

public class PBRuleEventGoodsRewardData: PBModel {

    public var goodsId:String! = ""
    public var imageURL:String! = ""
    public var name:String! = ""
    public var desc:String! = ""
    public var perUser:Int = 0
    public var quantity:Int = 0
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        goodsId <- map["goods_id"]
        imageURL <- map["image"]
        name <- map["name"]
        desc <- map["description"]
        perUser <- map["per_user"]
        quantity <- map["quantity"]
    }
    
    public init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBRuleEventGoodsRewardData>().map(apiResponse.parsedJson!, toObject: self)
    }
    
    public class func pbRuleEventGoodsRewardDataFromApiResponse(apiResponse:PBApiResponse) -> [PBRuleEventGoodsRewardData] {
        var ruleEventGoodsRewardDataList:[PBRuleEventGoodsRewardData] = []
        ruleEventGoodsRewardDataList = Mapper<PBRuleEventGoodsRewardData>().mapArray(apiResponse.parsedJson!)!
        return ruleEventGoodsRewardDataList
    }
    
}

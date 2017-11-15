//
//  PBRuleEventGoodsRewardData.swift
//  Pods
//
//  Created by Nuttapol Thitaweera on 8/16/2559 BE.
//
//

import UIKit
import ObjectMapper

open class PBRuleEventGoodsRewardData: PBModel {

    open var goodsId:String! = ""
    open var imageURL:String! = ""
    open var name:String! = ""
    open var desc:String! = ""
    open var perUser:Int = 0
    open var code:String?
    open var quantity:Int = 0
    open var tags:[String]?
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        goodsId <- map["goods_id"]
        imageURL <- map["image"]
        name <- map["name"]
        desc <- map["description"]
        perUser <- map["per_user"]
        quantity <- map["quantity"]
        code <- map["code"]
        tags <- map["tags"]

    }
    
    public init(apiResponse:PBApiResponse) {
        super.init()
        _ = Mapper<PBRuleEventGoodsRewardData>().map(JSONObject: apiResponse.parsedJson!, toObject: self)
    }
    
    open class func pbRuleEventGoodsRewardDataFromApiResponse(_ apiResponse:PBApiResponse) -> [PBRuleEventGoodsRewardData] {
        var ruleEventGoodsRewardDataList:[PBRuleEventGoodsRewardData] = []
        ruleEventGoodsRewardDataList = Mapper<PBRuleEventGoodsRewardData>().mapArray(JSONObject: apiResponse.parsedJson!)!
        return ruleEventGoodsRewardDataList
    }
    
}

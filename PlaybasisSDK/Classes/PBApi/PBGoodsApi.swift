//
//  PBGoodsApi.swift
//  Playbook
//
//  Created by Mederic PETIT on 6/20/16.
//  Copyright © 2016 smartsoftasia. All rights reserved.
//

import UIKit

open class PBGoodsApi: PBBaseApi {

    fileprivate class func goodsEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.GOODS_END_POINT + self.encodePath(path)
    }
    
    
    open class func goodListWithPlayerId(_ playerId:String? = nil, tags:String, completionBlock:@escaping PBGoodsCompletionBlock, failureBlock:PBFailureErrorBlock) {
        var params = ["tags":tags]
        if playerId != nil {
            params["player_id"] = playerId!
        }
        PBRestController.request(.get, endPoint: goodsEndPointWithPath(""), parameters: params, completionBlock: { (apiResponse) in
            completionBlock(PBRewardData.pbGoodsFromApiResponse(apiResponse))
            }, failureBlock:failureBlock)
    }

    
    open class func verifyCouponWithGoodId(_ goodId:String, couponCode:String, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params = ["goods_id":goodId, "coupon_code":couponCode]
        PBRestController.request(.get, endPoint: goodsEndPointWithPath("couponVerify"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
    open class func redeemCouponWithGoodId(_ goodId:String, couponCode:String, playerId:String, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params = ["goods_id":goodId, "coupon_code":couponCode, "player_id":playerId]
        PBRestController.request(.POST, endPoint: goodsEndPointWithPath("couponVerify"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
    open class func getGoodsWithGoodIdAndPlayerId(_ goodId:String,playerId:String, completionBlock:@escaping (_ goods:PBGoods) -> Void, failureBlock:PBFailureErrorBlock) {
        let params = ["player_id":playerId]
        PBRestController.request(.GET, endPoint: goodsEndPointWithPath("\(goodId)"), parameters: params, completionBlock: { (response) in
            let goods = PBGoods.init(apiResponse: response)
            completionBlock(goods: goods)
        }, failureBlock:failureBlock)
    }

}

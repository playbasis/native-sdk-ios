//
//  PBGoodsApi.swift
//  Playbook
//
//  Created by Mederic PETIT on 6/20/16.
//  Copyright © 2016 smartsoftasia. All rights reserved.
//

import UIKit

public class PBGoodsApi: PBBaseApi {

    private class func goodsEndPointWithPath(path:String) -> String {
        return PBEndPoint.GOODS_END_POINT + path
    }
    
    
    public class func goodListWithPlayerId(playerId:String? = nil, tags:String, completionBlock:PBGoodsCompletionBlock, failureBlock:PBFailureErrorBlock) {
        var params = ["tags":tags]
        if playerId != nil {
            params["player_id"] = playerId!
        }
        PBRestController.request(.GET, endPoint: goodsEndPointWithPath(""), parameters: params, completionBlock: { (apiResponse) in
            completionBlock(PBRewardData.pbGoodsFromApiResponse(apiResponse))
            }, failureBlock:failureBlock)
    }

    
    public class func verifyCouponWithGoodId(goodId:String, couponCode:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params = ["goods_id":goodId, "coupon_code":couponCode]
        PBRestController.request(.GET, endPoint: goodsEndPointWithPath("couponVerify"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
    public class func redeemCouponWithGoodId(goodId:String, couponCode:String, playerId:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params = ["goods_id":goodId, "coupon_code":couponCode, "player_id":playerId]
        PBRestController.request(.POST, endPoint: goodsEndPointWithPath("couponVerify"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
    public class func getGoodsWithGoodIdAndPlayerId(goodId:String,playerId:String, completionBlock:(goods:PBGoods) -> Void, failureBlock:PBFailureErrorBlock) {
        let params = ["player_id":playerId]
        PBRestController.request(.GET, endPoint: goodsEndPointWithPath("\(goodId)"), parameters: params, completionBlock: { (response) in
            let goods = PBGoods.init(apiResponse: response)
            completionBlock(goods: goods)
        }, failureBlock:failureBlock)
    }

}

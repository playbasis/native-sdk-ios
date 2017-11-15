//
//  PBMerchantApi.swift
//  Pods
//
//  Created by Médéric Petit on 8/25/2559 BE.
//
//

import UIKit

open class PBMerchantApi: PBBaseApi {

    fileprivate class func merchantEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.MERCHANT_END_POINT + self.encodePath(path)
    }
    
    open class func availableBranchForGoodsGroup(_ goodsGroup:String, completionBlock:@escaping PBAvailableRedeemPlacesCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        let params = ["goods_group":goodsGroup]
        PBRestController.request(.get, endPoint: merchantEndPointWithPath("availableBranchGoodsGroup"), parameters: params, completionBlock: { (apiResponse) in
            let redeemPlaces = PBRedeemPlace.pbRedeemPlacesFromApiResponse(apiResponse)
            completionBlock(redeemPlaces)
            }, failureBlock:failureBlock)
    }
    
    open class func redeemCouponWithGroup(_ group:String, code:String, pinCode:String?, playerId:String?, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        var params = ["goods_group":group, "coupon_code":code]
        if let mPinCode = pinCode {
            params["pin_code"] = mPinCode
        }
        if let mPlayerId = playerId {
            params["player_id"] = mPlayerId
        }
        PBRestController.request(.post, endPoint: merchantEndPointWithPath("goodsGroup/redeem"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }

    
}

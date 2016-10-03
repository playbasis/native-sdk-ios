//
//  PBMerchantApi.swift
//  Pods
//
//  Created by Médéric Petit on 8/25/2559 BE.
//
//

import UIKit

public class PBMerchantApi: PBBaseApi {

    private class func merchantEndPointWithPath(path:String) -> String {
        return PBEndPoint.MERCHANT_END_POINT + path
    }
    
    public class func availableBranchForGoodsGroup(goodsGroup:String, completionBlock:PBAvailableRedeemPlacesCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params = ["goods_group":goodsGroup]
        PBRestController.request(.GET, endPoint: merchantEndPointWithPath("availableBranchGoodsGroup"), parameters: params, completionBlock: { (apiResponse) in
            let redeemPlaces = PBRedeemPlace.pbRedeemPlacesFromApiResponse(apiResponse)
            completionBlock(redeemPlaces: redeemPlaces)
            }, failureBlock:failureBlock)
    }
    
    public class func redeemCouponWithGroup(group:String, code:String, pinCode:String?, playerId:String?, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        var params = ["goods_group":group, "coupon_code":code]
        if let mPinCode = pinCode {
            params["pin_code"] = mPinCode
        }
        if let mPlayerId = playerId {
            params["player_id"] = mPlayerId
        }
        PBRestController.request(.POST, endPoint: merchantEndPointWithPath("goodsGroup/redeem"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }

    
}

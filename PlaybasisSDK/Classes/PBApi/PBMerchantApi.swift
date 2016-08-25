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
    
}

//
//  PBRedeemApi.swift
//  Playbook
//
//  Created by Médéric Petit on 8/10/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

public class PBRedeemApi: PBBaseApi {
    
    private class func redeemEndPointWithPath(path:String) -> String {
        return PBEndPoint.REDEEM_END_POINT + path
    }
    
    public class func redeemGoodId(goodId:String, playerId:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params = ["goods_id":goodId, "player_id":playerId]
        PBRestController.request(.POST, endPoint: redeemEndPointWithPath("goods"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
    public class func redeemGoodGroupWithGroup(group:String, playerId:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params = ["player_id":playerId, "group":group]
        PBRestController.request(.POST, endPoint: redeemEndPointWithPath("goodsGroup"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
    public class func redeemVerificationWithGroup(group:String, code:String, pinCode:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params = ["pin_code":pinCode, "goods_group":group, "coupon_code":code]
        PBRestController.request(.POST, endPoint: redeemEndPointWithPath("goodsGroup/verify"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }

}

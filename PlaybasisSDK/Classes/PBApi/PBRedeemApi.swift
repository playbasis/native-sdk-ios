//
//  PBRedeemApi.swift
//  Playbook
//
//  Created by Médéric Petit on 8/10/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

class PBRedeemApi: PBBaseApi {
    
    private class func redeemEndPointWithPath(path:String) -> String {
        return PBEndPoint.REDEEM_END_POINT + path
    }
    
    class func redeemGoodId(goodId:String, playerId:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params = ["goods_id":goodId, "player_id":playerId]
        PBRestController.request(.POST, endPoint: redeemEndPointWithPath("goods"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
    class func redeemGoodGroupWithGroup(group:String, playerId:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params = ["player_id":playerId, "group":group]
        PBRestController.request(.POST, endPoint: redeemEndPointWithPath("goodsGroup"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
}

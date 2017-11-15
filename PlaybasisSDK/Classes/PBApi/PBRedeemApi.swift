//
//  PBRedeemApi.swift
//  Playbook
//
//  Created by Médéric Petit on 8/10/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

open class PBRedeemApi: PBBaseApi {
    
    fileprivate class func redeemEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.REDEEM_END_POINT + self.encodePath(path)
    }
    
    open class func redeemGoodId(_ goodId:String, playerId:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params = ["goods_id":goodId, "player_id":playerId]
        PBRestController.request(.post, endPoint: redeemEndPointWithPath("goods"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
    open class func redeemGoodGroupWithGroup(_ group:String, playerId:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params = ["player_id":playerId, "group":group]
        PBRestController.request(.post, endPoint: redeemEndPointWithPath("goodsGroup"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
            }, failureBlock:failureBlock)
    }
    
}

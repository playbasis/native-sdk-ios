//
//  PBPointApi.swift
//  Pods
//
//  Created by Mederic PETIT on 11/14/16.
//
//

import UIKit

open class PBPointApi: PBBaseApi {
    
    fileprivate class func pointEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.POINT_END_POINT + self.encodePath(path)
    }
    
    open class func getRemainingPointWithName(_ name:String?,completionBlock:@escaping PBRemainingPointsCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        var params:[String:String] = [:]
        if let mName:String = name {
            params["name"] = mName
        }
        PBRestController.request(.get, endPoint: pointEndPointWithPath("custom/remaining"), parameters: params, completionBlock: { (apiResponse) in
            if apiResponse.parsedJson != nil {
                completionBlock(remainingPoints: PBRemainingPoint.pbRemainingPointFromPointsApiResponse(apiResponse))
            }
            else {
                failureBlock(error: PBError(message: "Unknown error"))
            }
            }, failureBlock:failureBlock)
    }
    
    open class func approveTransactions(_ transactions:[String], approve:Bool, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        let params:[String:String] = ["transaction_list":transactions.joined(separator: ","), "approve":String(approve)]
        PBRestController.request(.post, endPoint: pointEndPointWithPath("custom/approval"), parameters: params, completionBlock: { (apiResponse) in
            if apiResponse.parsedJson != nil {
                completionBlock()
            }
            else {
                failureBlock(error: PBError(message: "Unknown error"))
            }
            }, failureBlock:failureBlock)
    }

}

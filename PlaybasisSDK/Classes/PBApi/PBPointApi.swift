//
//  PBPointApi.swift
//  Pods
//
//  Created by Mederic PETIT on 11/14/16.
//
//

import UIKit

public class PBPointApi: PBBaseApi {
    
    private class func pointEndPointWithPath(path:String) -> String {
        return PBEndPoint.SETTING_END_POINT + path
    }
    
    public class func getRemainingPointWithName(name:String?,completionBlock:PBRemainingPointsCompletionBlock, failureBlock:PBFailureErrorBlock) {
        var params:[String:String] = [:]
        if let mName:String = name {
            params["name"] = mName
        }
        PBRestController.request(.GET, endPoint: pointEndPointWithPath("custom/remaining"), parameters: params, completionBlock: { (apiResponse) in
            if apiResponse.parsedJson != nil {
                completionBlock(remainingPoints: PBRemainingPoint.pbRemainingPointFromPointsApiResponse(apiResponse))
            }
            else {
                failureBlock(error: PBError(message: "Unknown error"))
            }
            }, failureBlock:failureBlock)
    }
    
    public class func approveTransactions(transactions:[String], completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params:[String:String] = ["transaction_list":transactions.joinWithSeparator(",")]
        PBRestController.request(.POST, endPoint: pointEndPointWithPath("custom/approval"), parameters: params, completionBlock: { (apiResponse) in
            if apiResponse.parsedJson != nil {
                completionBlock()
            }
            else {
                failureBlock(error: PBError(message: "Unknown error"))
            }
            }, failureBlock:failureBlock)
    }

}

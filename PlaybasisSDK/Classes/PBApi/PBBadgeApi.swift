//
//  PBBadgeApi.swift
//  Pods
//
//  Created by Mederic PETIT on 11/14/16.
//
//

import UIKit

public class PBBadgeApi: PBBaseApi {
    
    private class func badgeEndPointWithPath(path:String) -> String {
        return PBEndPoint.BADGE_END_POINT + path
    }
    
    public class func getAllBadgesWithTags(tags:String?, completionBlock:PBPlayerBadgesCompletionBlock, failureBlock:PBFailureErrorBlock) {
            var params:[String:String] = [:]
            if let mTag:String = tags {
                params["tags"] = mTag
            }
            PBRestController.request(.GET, endPoint: badgeEndPointWithPath(""), parameters: params, completionBlock: { (apiResponse) in
                
                if let json:[String:AnyObject] = apiResponse.parsedJson as? [String:AnyObject] {
                    completionBlock(PBBadge.pbBadgesFromDicArray(json["badges"] as! [AnyObject]))
                }
                else {
                    failureBlock(error: PBError(message: "Unknown error"))
                }

                }, failureBlock: failureBlock)
    }

}

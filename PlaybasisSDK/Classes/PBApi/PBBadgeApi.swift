//
//  PBBadgeApi.swift
//  Pods
//
//  Created by Mederic PETIT on 11/14/16.
//
//

import UIKit

open class PBBadgeApi: PBBaseApi {
    
    fileprivate class func badgeEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.BADGE_END_POINT + self.encodePath(path)
    }
    
    open class func getAllBadgesWithTags(_ tags:String?, completionBlock:@escaping PBPlayerBadgesCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
            var params:[String:String] = [:]
            if let mTag:String = tags {
                params["tags"] = mTag
            }
        PBRestController.request(.get, endPoint: badgeEndPointWithPath(""), parameters: params as [String : AnyObject], completionBlock: { (apiResponse) in
                
                if let json:[String:AnyObject] = apiResponse.parsedJson as? [String:AnyObject] {
                    completionBlock(PBBadge.pbBadgesFromDicArray(json["badges"] as! [AnyObject]))
                }
                else {
                    failureBlock(PBError(message: "Unknown error"))
                }

                }, failureBlock: failureBlock)
    }

}

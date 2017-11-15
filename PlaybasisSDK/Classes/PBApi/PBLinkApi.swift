//
//  PBLinkApi.swift
//  Pods
//
//  Created by Médéric Petit on 9/20/2559 BE.
//
//

import UIKit

open class PBLinkApi: PBBaseApi {

    fileprivate class func linkEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.LINK_END_POINT + self.encodePath(path)
    }
    
    open class func generateLinkWithParams(_ params:[String:String], completionBlock:PBLinkCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.post, endPoint: linkEndPointWithPath("generate"), parameters: params, completionBlock: { (response) in
            if let json:[String:AnyObject] = response.parsedJson as? [String:AnyObject], let link:String = json["link"] as? String {
                completionBlock(link: link)
            }
            else {
                failureBlock(error: PBError(message: "Unknown Error"))
            }
            }, failureBlock:failureBlock)
    }
}

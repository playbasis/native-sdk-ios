//
//  PBLinkApi.swift
//  Pods
//
//  Created by Médéric Petit on 9/20/2559 BE.
//
//

import UIKit

public class PBLinkApi: PBBaseApi {

    private class func linkEndPointWithPath(path:String) -> String {
        return PBEndPoint.LINK_END_POINT + self.encodePath(path)
    }
    
    public class func generateLinkWithParams(params:[String:String], completionBlock:PBLinkCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.POST, endPoint: linkEndPointWithPath("generate"), parameters: params, completionBlock: { (response) in
            if let json:[String:AnyObject] = response.parsedJson as? [String:AnyObject], let link:String = json["link"] as? String {
                completionBlock(link: link)
            }
            else {
                failureBlock(error: PBError(message: "Unknown Error"))
            }
            }, failureBlock:failureBlock)
    }
}

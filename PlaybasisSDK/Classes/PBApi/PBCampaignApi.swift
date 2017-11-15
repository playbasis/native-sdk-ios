//
//  PBCampaignApi.swift
//  Pods
//
//  Created by Mederic PETIT on 11/24/16.
//
//

import UIKit

open class PBCampaignApi: PBBaseApi {

    fileprivate class func campaignEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.CAMPAIGN_END_POINT + self.encodePath(path)
    }
    
    open class func getCampaignWithName(_ campaignName:String, completionBlock:@escaping PBCampaignsCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        let params:[String:String] = ["campaign_name":campaignName]
        PBRestController.request(.get, endPoint: campaignEndPointWithPath(""), parameters: params, completionBlock: { (apiResponse) in
            if apiResponse.parsedJson != nil {
                completionBlock(PBCampaign.pbCampaignsFromApiResponse(apiResponse))
            }
            else {
                failureBlock(PBError(message: "Unknown error"))
            }
            }, failureBlock:failureBlock)
    }
}

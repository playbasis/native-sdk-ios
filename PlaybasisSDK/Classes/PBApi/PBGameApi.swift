//
//  PBGameApi.swift
//  Pods
//
//  Created by Mederic PETIT on 11/14/16.
//
//

import UIKit

open class PBGameApi: PBBaseApi {
    
    fileprivate class func gameEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.GAME_END_POINT + self.encodePath(path)
    }
    
    open class func getGameSettingsWithForm(_ gameForm:PBGameForm?,completionBlock:@escaping PBGameSettingCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        var params:[String:String] = [:]
        if let mGameForm:PBGameForm = gameForm {
            params = mGameForm.params()
        }
        PBRestController.request(.get, endPoint: gameEndPointWithPath(""), parameters: params, completionBlock: { (apiResponse) in
            if apiResponse.parsedJson != nil {
                completionBlock(PBGameSetting.pbGameSettingsFromApiResponse(apiResponse))
            }
            else {
                failureBlock(PBError(message: "Unknown error"))
            }
            }, failureBlock:failureBlock)
    }
    
    open class func getActiveGameCampaign(_ gameName:String, completionBlock:@escaping PBCampaignCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        let params:[String:String] = ["game_name":gameName]
        PBRestController.request(.get, endPoint: gameEndPointWithPath("campaign/active"), parameters: params, completionBlock: { (apiResponse) in
            if apiResponse.parsedJson != nil {
                completionBlock(PBCampaign(apiResponse: apiResponse))
            }
            else {
                failureBlock(PBError(message: "Unknown error"))
            }
            }, failureBlock:failureBlock)
    }

}

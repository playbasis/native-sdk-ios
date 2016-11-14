//
//  PBGameApi.swift
//  Pods
//
//  Created by Mederic PETIT on 11/14/16.
//
//

import UIKit

public class PBGameApi: PBBaseApi {
    
    private class func gameEndPointWithPath(path:String) -> String {
        return PBEndPoint.GAME_END_POINT + path
    }
    
    public class func getGameSettingsWithForm(gameForm:PBGameForm?,completionBlock:PBGameSettingCompletionBlock, failureBlock:PBFailureErrorBlock) {
        var params:[String:String] = [:]
        if let mGameForm:PBGameForm = gameForm {
            params = mGameForm.params()
        }
        PBRestController.request(.GET, endPoint: gameEndPointWithPath(""), parameters: params, completionBlock: { (apiResponse) in
            if apiResponse.parsedJson != nil {
                completionBlock(gameSettings: PBGameSetting.pbGameSettingsFromApiResponse(apiResponse))
            }
            else {
                failureBlock(error: PBError(message: "Unknown error"))
            }
            }, failureBlock:failureBlock)
    }

}

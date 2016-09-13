//
//  PBPlayerApi.swift
//  Playbook
//
//  Created by Médéric Petit on 6/14/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

public enum RankType:String{
    case Point = "point"
    case Token = "token"
    case Gold = "gold"
}

public class PBPlayerApi: PBBaseApi {
        
    private class func playerEndPointWithPath(path:String) -> String {
        return PBEndPoint.PLAYER_END_POINT + path
    }
    
    public class func getPublicInfoForPlayerId(playerId:String, completionBlock:PBPlayerCompletionBlock, failureBlock:PBFailureErrorBlock) {
        PBRestController.request(.GET, endPoint: playerEndPointWithPath(playerId), parameters: nil, completionBlock: { (apiResponse) in
            let player:PBPlayer = PBPlayer(apiResponse: apiResponse)
            player.playerId = playerId
            completionBlock(player: player)
            }, failureBlock:failureBlock)
    }
    
    public class func getPrivateInfoForPlayerId(playerId:String, completionBlock:PBPlayerCompletionBlock, failureBlock:PBFailureErrorBlock) {
        PBRestController.request(.POST, endPoint: playerEndPointWithPath(playerId), parameters: nil, completionBlock: { (apiResponse) in
            let player:PBPlayer = PBPlayer(apiResponse: apiResponse)
            player.playerId = playerId
            completionBlock(player: player)
            }, failureBlock:failureBlock)
    }
    
    public class func getAllPrivateInfoForPlayerId(playerId:String, completionBlock:PBPlayerCompletionBlock, failureBlock:PBFailureErrorBlock) {
        PBRestController.request(.POST, endPoint: playerEndPointWithPath("\(playerId)/data/all"), parameters: nil, completionBlock: { (apiResponse) in
            let player:PBPlayer = PBPlayer(apiResponse: apiResponse)
            player.playerId = playerId
            completionBlock(player: player)
        }, failureBlock:failureBlock)
    }
    
    
    public class func getCustomFieldsForPlayerId(playerId:String, completionBlock:PBPlayerCustomFieldsCompletionBlock, failureBlock:PBFailureErrorBlock) {
        PBRestController.request(.GET, endPoint: playerEndPointWithPath("\(playerId)/custom"), parameters: nil, completionBlock: { (apiResponse) in
            if  let customFields:[String:String] = apiResponse.parsedJson?["player"]!!["custom"] as? [String:String]{
                 completionBlock(customFields: customFields)
            }else{
                completionBlock(customFields: [:])
            }
        }, failureBlock:failureBlock)
    }
    
    public class func getAllPlayerInfoForPlayerId(playerId:String, completionBlock:PBPlayerCompletionBlock, failureBlock:PBFailureErrorBlock) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let downloadGroup = dispatch_group_create()
            var player:PBPlayer? = nil
            var customFields:[String:String]? = nil
            var error:PBError? = nil
            dispatch_group_enter(downloadGroup)
            PBPlayerApi.getAllPrivateInfoForPlayerId(playerId, completionBlock: { (mPlayer) in
                dispatch_group_leave(downloadGroup)
                player = mPlayer
                }, failureBlock: { (mError) in
                    error = mError
                    dispatch_group_leave(downloadGroup)
            })
            dispatch_group_enter(downloadGroup)
            PBPlayerApi.getCustomFieldsForPlayerId(playerId, completionBlock: { (mCustomFields) in
                customFields = mCustomFields
                dispatch_group_leave(downloadGroup)
                }, failureBlock: { (mError) in
                    error = mError
                    dispatch_group_leave(downloadGroup)
            })
            dispatch_group_wait(downloadGroup, DISPATCH_TIME_FOREVER) // 5
            dispatch_async(dispatch_get_main_queue()) { // 6
                if error == nil && player != nil {
                    player!.customFields = customFields
                    completionBlock(player: player!)
                }
                else {
                    failureBlock(error: error!)
                }
            }
        }
        
    }

    
    
    public class func loginWithLoginForm(loginForm:PBLoginForm, completionBlock:PBPlayerAuthCompletionBlock, failureBlock:PBFailureErrorBlock) {
        guard loginForm.isValid() else {
            failureBlock(error:loginForm.validationError!)
            return
        }
        PBRestController.request(.POST, endPoint: playerEndPointWithPath("auth"), parameters: loginForm.params(), completionBlock: { (apiResponse) in
            let playerId:String = apiResponse.parsedJson!["cl_player_id"] as! String
            completionBlock(playerId:playerId)
            }, failureBlock:failureBlock)
    }
    
    
    public class func registerPlayerWithPlayerForm(registerForm:PBRegisterForm, completionBlock:PBPlayerCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBPlayerApi.postProfilePicture(registerForm.profilePicture, completionBlock: { (imageUrl) in
            registerForm.profilePictureUrl = imageUrl
            print(imageUrl)
            PBPlayerApi.updateMainData(registerForm, completionBlock: { (player) in
                guard registerForm.customFields != nil else {
                    completionBlock(player: player)
                    return
                }
                PBPlayerApi.updateCustomFieldsForPlayer(player, customFields: registerForm.customFields!, completionBlock: {
                    completionBlock(player: player)
                    }, failureBlock: failureBlock)
                }, failureBlock: failureBlock)
            }, failureBlock: failureBlock)
    }
    
    public class func resetPlayerPasswordWithEmail(email:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock){
        let params = ["email" : email]
        PBRestController.request(.POST, endPoint: playerEndPointWithPath("password/email"), parameters: params, completionBlock: { (apiResponse) in
            completionBlock()
        }, failureBlock:failureBlock)
        
    }
    
    
    public class func getBadgeWithPlayerId(playerId:String,completionBlock:
        PBPlayerBadgesCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.GET, endPoint: playerEndPointWithPath("\(playerId)/badge"), parameters: nil, completionBlock: { (response) in
            completionBlock(PBBadge.pbBadgeFromApiResponse(response))
        }, failureBlock: failureBlock)
    }
    
    public class func getBadgeCollectionWithPlayerId(playerId:String,completionBlock:
        PBPlayerBadgesCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.GET, endPoint: playerEndPointWithPath("\(playerId)/badgeAll"), parameters: nil, completionBlock: { (response) in
            completionBlock(PBBadge.pbBadgeFromApiResponse(response))
            }, failureBlock: failureBlock)
    }
    
    public class func updateCustomFieldsForPlayer(player:PBPlayer, customFields:[String:AnyObject], completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        var newCustomFields:[String:String] = player.customFields ?? [:]
        
        customFields.forEach { (key, value) in
            newCustomFields[key] = value as? String
        }
        let keys = newCustomFields.keys.joinWithSeparator(",")
        var valueArray:[String] = []
        for value in newCustomFields.values {
            valueArray.append(value)
        }
        let values = valueArray.joinWithSeparator(",")
        
        let params:[String:AnyObject] = ["key":keys, "value":values]
        
        PBRestController.request(.POST, endPoint: playerEndPointWithPath("\(player.playerId)/custom"), parameters: params, completionBlock: { (apiResponse) in
            player.customFields = customFields as? [String:String]
            completionBlock()
            }, failureBlock:failureBlock)
        
        
    }
    
    public class func getAllQuestWithPlayerId(playerId:String,completionBlock:PBQuestsCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.GET, endPoint: playerEndPointWithPath("questAll/\(playerId)"), parameters: nil, completionBlock: { (apiResponse) in
            let quests:[PBQuest] = PBQuest.pbQuestFromApiResponse(apiResponse)
            completionBlock(quests)
            }, failureBlock:failureBlock)
    }

    
    public class func getAllGoodsWithPlayerId(playerId:String,completionBlock:PBGoodsCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.GET, endPoint: playerEndPointWithPath("\(playerId)/goods"), parameters: nil, completionBlock: { (apiResponse) in
            completionBlock(PBRewardData.pbSmallGoodsFromApiResponse(apiResponse))
        }, failureBlock:failureBlock)
    }
    
    public class func updateProfilePicture(playerId:String, picture:UIImage?, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock){
       
        PBPlayerApi.postProfilePicture(picture, completionBlock: { (imageUrl) in
            
            var params:[String:String] = [:]
            params["image"] = imageUrl
            
            PBRestController.request(.POST, endPoint: playerEndPointWithPath("\(playerId)/update"), parameters: params, completionBlock: { (apiResponse) in
                completionBlock()
                }, failureBlock:failureBlock)

            
            }, failureBlock: failureBlock)

    }
    
    public class func getPointsWithPlayerId(playerId:String, completionBlock:PBPointsCompletionBlock, failureBlock:PBFailureErrorBlock) {
        PBRestController.request(.GET, endPoint: playerEndPointWithPath("\(playerId)/points"), parameters: nil, completionBlock: { (response) in
            let points:[PBPoint] = PBPoint.pbPointFromPointsApiResponse(response)
            completionBlock(points)
            }, failureBlock: failureBlock)
    }
    
    public class func updatePlayerWithPlayerForm(playerForm:PBPlayerForm, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        PBRestController.request(.POST, endPoint: playerEndPointWithPath("\(playerForm.playerId)/update"), parameters: playerForm.params(), completionBlock: { (response) in
            completionBlock()
            }, failureBlock: failureBlock)
    }

    public class func requestOTPWithPlayerId(playerId:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params:[String:String] = ["id":playerId]
        PBRestController.request(.POST, endPoint: playerEndPointWithPath("auth/\(playerId)/requestOTPCode"), parameters: params, completionBlock: { (response) in
            completionBlock()
            }, failureBlock: failureBlock)
    }
    
    public class func requestOTPForPhoneSetupWithDeviceForm(deviceForm:PBDeviceForm, phoneNumber:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        var params:[String:String] = deviceForm.params()
        params["phone_number"] = phoneNumber
        PBRestController.request(.POST, endPoint: playerEndPointWithPath("auth/\(deviceForm.playerId)/setupPhone"), parameters: params, completionBlock: { (response) in
            completionBlock()
            }, failureBlock: failureBlock)
    }
    
    public class func submitOTPWithPlayerId(playerId:String, OTP:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock) {
        let params:[String:String] = ["id":playerId, "code":OTP]
        PBRestController.request(.POST, endPoint: playerEndPointWithPath("auth/\(playerId)/verifyOTPCode"), parameters: params, completionBlock: { (response) in
            completionBlock()
            }, failureBlock: failureBlock)
    }

    public class func getRankWithRankTypeAndLimit(rankType:RankType,limit:Int, completionBlock:PBRanksCompletionBlock, failureBlock:PBFailureErrorBlock){
        
        PBRestController.request(.GET, endPoint: playerEndPointWithPath("rank/\(rankType.rawValue)/\(limit)"), parameters: nil, completionBlock: { (response) in
            let ranks:[PBRank] = PBRank.pbrankFromApiResponse(response)
            completionBlock(ranks)
        }, failureBlock:failureBlock)
        
    }
    
    public class func getActionReportWithPlayerId(pbActionReportForm:PBActionReportForm,completionBlock:PBActionReportsCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.GET, endPoint: playerEndPointWithPath("\(pbActionReportForm.playerId)/actionReport"), parameters: pbActionReportForm.params(), completionBlock: { (response) in
            let actionReports:[PBActionReport] = PBActionReport.pbActionReportFromApiResponse(response)
            completionBlock(actionReports)
            }, failureBlock:failureBlock)
    }

    // MARK: - Private
    
    private class func updateMainData(registerForm:PBRegisterForm, completionBlock:PBPlayerCompletionBlock, failureBlock:PBFailureErrorBlock) {
        PBRestController.request(.POST, endPoint: playerEndPointWithPath("\(registerForm.playerId!)/register"), parameters: registerForm.params(), completionBlock: { (apiResponse) in
            let player:PBPlayer = PBPlayer(registerForm:registerForm)
            completionBlock(player: player)
            }, failureBlock:failureBlock)
    }
    
    private class func postProfilePicture(picture:UIImage?, completionBlock:(imageUrl:String?) -> Void, failureBlock:PBFailureErrorBlock) {
        if picture == nil {
            completionBlock(imageUrl: nil)
            return
        }
        let profilePictureData:NSData = UIImageJPEGRepresentation(picture!, 0.7)!
        PBRestController.uploadData(profilePictureData, endPoint: "File/upload", parameters: nil, completionBlock: { (response) in
            if let json = response.parsedJson {
                completionBlock(imageUrl: json["url"] as? String)
            }
            }, failureBlock: failureBlock)
    }
    
}

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

open class PBPlayerApi: PBBaseApi {
        
    fileprivate class func playerEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.PLAYER_END_POINT + self.encodePath(path)
    }
    
    open class func getPublicInfoForPlayerId(_ playerId:String, completionBlock:@escaping PBPlayerCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        PBRestController.request(.get, endPoint: playerEndPointWithPath(playerId), completionBlock: { (apiResponse) in
            let player:PBPlayer = PBPlayer(apiResponse: apiResponse)
            player.playerId = playerId
            completionBlock(player)
            }, failureBlock:failureBlock)
    }
    
    open class func getPrivateInfoForPlayerId(_ playerId:String, completionBlock:@escaping PBPlayerCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        PBRestController.request(.post, endPoint: playerEndPointWithPath(playerId), completionBlock: { (apiResponse) in
            let player:PBPlayer = PBPlayer(apiResponse: apiResponse)
            player.playerId = playerId
            completionBlock(player)
            }, failureBlock:failureBlock)
    }
    
    open class func getAllPrivateInfoForPlayerId(_ playerId:String, completionBlock:@escaping PBPlayerCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        PBRestController.request(.post, endPoint: playerEndPointWithPath("\(playerId)/data/all"), completionBlock: { (apiResponse) in
            let player:PBPlayer = PBPlayer(apiResponse: apiResponse)
            player.playerId = playerId
            completionBlock(player)
        }, failureBlock:failureBlock)
    }
    
    
    open class func getCustomFieldsForPlayerId(_ playerId:String, completionBlock:@escaping PBPlayerCustomFieldsCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        PBRestController.request(.get, endPoint: playerEndPointWithPath("\(playerId)/custom"), completionBlock: { (apiResponse) in
            let parsedJson = apiResponse.parsedJson as? [String: AnyObject]
            if  let customFields:[String:String] = parsedJson?["player"]!["custom"] as? [String:String]{
                 completionBlock(customFields)
            }else{
                completionBlock([:])
            }
        }, failureBlock:failureBlock)
    }
    
    open class func getAllPlayerInfoForPlayerId(_ playerId:String, completionBlock:@escaping PBPlayerCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let downloadGroup = DispatchGroup()
            var player:PBPlayer? = nil
            var customFields:[String:String]? = nil
            var error:PBError? = nil
            downloadGroup.enter()
            PBPlayerApi.getAllPrivateInfoForPlayerId(playerId, completionBlock: { (mPlayer) in
                downloadGroup.leave()
                player = mPlayer
                }, failureBlock: { (mError) in
                    error = mError
                    downloadGroup.leave()
            })
            downloadGroup.enter()
            PBPlayerApi.getCustomFieldsForPlayerId(playerId, completionBlock: { (mCustomFields) in
                customFields = mCustomFields
                downloadGroup.leave()
                }, failureBlock: { (mError) in
                    error = mError
                    downloadGroup.leave()
            })
            _ = downloadGroup.wait(timeout: DispatchTime.distantFuture) // 5
            DispatchQueue.main.async { // 6
                if error == nil && player != nil {
                    player!.customFields = customFields
                    completionBlock(player!)
                }
                else {
                    failureBlock(error!)
                }
            }
        }
        
    }

    
    
    open class func loginWithLoginForm(_ loginForm:PBLoginForm, completionBlock:@escaping PBPlayerAuthCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        guard loginForm.isValid() else {
            failureBlock(loginForm.validationError!)
            return
        }
        PBRestController.request(.post, endPoint: playerEndPointWithPath("auth"), parameters: loginForm.params() as [String : AnyObject], completionBlock: { (apiResponse) in
            let playerId:String = apiResponse.parsedJson!["cl_player_id"] as! String
            completionBlock(playerId)
            }, failureBlock:failureBlock)
    }
    
    
    open class func registerPlayerWithPlayerForm(_ registerForm:PBRegisterForm, completionBlock:@escaping PBPlayerCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        PBPlayerApi.postProfilePicture(registerForm.profilePicture, completionBlock: { (imageUrl) in
            registerForm.profilePictureUrl = imageUrl
            print(imageUrl)
            PBPlayerApi.updateMainData(registerForm, completionBlock: { (player) in
                guard registerForm.customFields != nil else {
                    completionBlock(player)
                    return
                }
                PBPlayerApi.updateCustomFieldsForPlayer(player, customFields: registerForm.customFields! as [String : AnyObject], completionBlock: {
                    completionBlock(player)
                    }, failureBlock: failureBlock)
                }, failureBlock: failureBlock)
            }, failureBlock: failureBlock)
    }
    
    open class func resetPlayerPasswordWithEmail(_ email:String, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        let params = ["email" : email]
        PBRestController.request(.post, endPoint: playerEndPointWithPath("password/email"), parameters: params as [String : AnyObject], completionBlock: { (apiResponse) in
            completionBlock()
        }, failureBlock:failureBlock)
        
    }
    
    
    open class func getBadgeWithPlayerId(_ playerId:String,completionBlock:
        @escaping PBPlayerBadgesCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        PBRestController.request(.get, endPoint: playerEndPointWithPath("\(playerId)/badge"), completionBlock: { (response) in
            completionBlock(PBBadge.pbBadgeFromApiResponse(response))
        }, failureBlock: failureBlock)
    }
    
    open class func getBadgeCollectionWithPlayerId(_ playerId:String, tags:String?, completionBlock:
        @escaping PBPlayerBadgesCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        var params:[String:String] = [:]
        if let mTag:String = tags {
            params["tags"] = mTag
        }
        PBRestController.request(.get, endPoint: playerEndPointWithPath("\(playerId)/badgeAll"), parameters: params as [String : AnyObject], completionBlock: { (response) in
            completionBlock(PBBadge.pbBadgeFromApiResponse(response))
            }, failureBlock: failureBlock)
    }
    
    open class func updateCustomFieldsForPlayer(_ player:PBPlayer, customFields:[String:AnyObject], completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        var newCustomFields:[String:String] = player.customFields ?? [:]
        
        customFields.forEach { (key, value) in
            newCustomFields[key] = value as? String
        }
        let keys = newCustomFields.keys.joined(separator: ",")
        var valueArray:[String] = []
        for value in newCustomFields.values {
            valueArray.append(value)
        }
        let values = valueArray.joined(separator: ",")
        
        let params:[String:AnyObject] = ["key":keys as AnyObject, "value":values as AnyObject]
        
        PBRestController.request(.post, endPoint: playerEndPointWithPath("\(player.playerId)/custom"), parameters: params, completionBlock: { (apiResponse) in
            player.customFields = customFields as? [String:String]
            completionBlock()
            }, failureBlock:failureBlock)
        
        
    }
    
    open class func getAllQuestWithPlayerId(_ playerId:String,completionBlock:@escaping PBQuestsCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        PBRestController.request(.get, endPoint: playerEndPointWithPath("questAll/\(playerId)"), completionBlock: { (apiResponse) in
            let quests:[PBQuest] = PBQuest.pbQuestFromApiResponse(apiResponse)
            completionBlock(quests)
            }, failureBlock:failureBlock)
    }

    
    open class func getAllGoodsWithPlayerId(_ playerId:String, status:PBGoodStatus = .Active, tags:String? = nil,completionBlock:@escaping PBGoodsCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        var params:[String:String] = ["status":status.rawValue]
        if let mTags:String = tags {
            params["tags"] = mTags
        }
        PBRestController.request(.get, endPoint: playerEndPointWithPath("\(playerId)/goods"), parameters: params as [String : AnyObject], completionBlock: { (apiResponse) in
            completionBlock(PBRewardData.pbSmallGoodsFromApiResponse(apiResponse))
        }, failureBlock:failureBlock)
    }
    
    open class func updateProfilePicture(_ playerId:String, picture:UIImage?, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
       
        PBPlayerApi.postProfilePicture(picture, completionBlock: { (imageUrl) in
            
            var params:[String:String] = [:]
            params["image"] = imageUrl
            
            PBRestController.request(.post, endPoint: playerEndPointWithPath("\(playerId)/update"), parameters: params as [String : AnyObject], completionBlock: { (apiResponse) in
                completionBlock()
                }, failureBlock:failureBlock)

            
            }, failureBlock: failureBlock)

    }
    
    open class func getPointsWithPlayerId(_ playerId:String, completionBlock:@escaping PBPointsCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        PBRestController.request(.get, endPoint: playerEndPointWithPath("\(playerId)/points"), completionBlock: { (response) in
            let points:[PBPoint] = PBPoint.pbPointFromPointsApiResponse(response)
            completionBlock(points)
            }, failureBlock: failureBlock)
    }
    
    open class func updatePlayerWithPlayerForm(_ playerForm:PBPlayerForm, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        PBRestController.request(.post, endPoint: playerEndPointWithPath("\(playerForm.playerId)/update"), parameters: playerForm.params() as [String : AnyObject], completionBlock: { (response) in
            completionBlock()
            }, failureBlock: failureBlock)
    }

    open class func requestOTPWithPlayerId(_ playerId:String, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        let params:[String:String] = ["id":playerId]
        PBRestController.request(.post, endPoint: playerEndPointWithPath("auth/\(playerId)/requestOTPCode"), parameters: params as [String : AnyObject], completionBlock: { (response) in
            completionBlock()
            }, failureBlock: failureBlock)
    }
    
    open class func requestOTPForPhoneSetupWithPhoneNumber(_ phoneNumber:String, playerId:String, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        let params:[String:String] = ["phone_number":phoneNumber, "id":playerId]
        PBRestController.request(.post, endPoint: playerEndPointWithPath("auth/\(playerId)/setupPhone"), parameters: params as [String : AnyObject], completionBlock: { (response) in
            completionBlock()
            }, failureBlock: failureBlock)
    }
    
    open class func submitOTPWithPlayerId(_ playerId:String, OTP:String, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        let params:[String:String] = ["id":playerId, "code":OTP]
        PBRestController.request(.post, endPoint: playerEndPointWithPath("auth/\(playerId)/verifyOTPCode"), parameters: params as [String : AnyObject], completionBlock: { (response) in
            completionBlock()
            }, failureBlock: failureBlock)
    }

    open class func getRankWithRankTypeAndLimit(_ rankType:RankType,limit:Int, completionBlock:@escaping PBRanksCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        
        PBRestController.request(.get, endPoint: playerEndPointWithPath("rank/\(rankType.rawValue)/\(limit)"), completionBlock: { (response) in
            let ranks:[PBRank] = PBRank.pbrankFromApiResponse(response)
            completionBlock(ranks)
        }, failureBlock:failureBlock)
        
    }
    
    open class func getActionReportWithPlayerId(_ pbActionReportForm:PBActionReportForm,completionBlock:@escaping PBActionReportsCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        PBRestController.request(.get, endPoint: playerEndPointWithPath("\(pbActionReportForm.playerId)/actionReport"), parameters: pbActionReportForm.params() as [String : AnyObject], completionBlock: { (response) in
            let actionReports:[PBActionReport] = PBActionReport.pbActionReportFromApiResponse(response)
            completionBlock(actionReports)
            }, failureBlock:failureBlock)
    }
    
    open class func getReferralCodeWithPlayerId(_ playerId:String, completionBlock:@escaping PBReferralCodeCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        PBRestController.request(.get, endPoint: playerEndPointWithPath("\(playerId)/code"), completionBlock: { (response) in
            if let json:[String:AnyObject] = response.parsedJson as? [String:AnyObject], let code:String = json["code"] as? String {
                completionBlock(code)
            }
            else {
                failureBlock(PBError(message: "Unknown error"))
            }
            
            }, failureBlock: failureBlock)
    }
    
    open class func getActionCountWithPlayerId(_ playerId:String, actionName:String, customParams:[String:String]?, completionBlock:@escaping PBActionCountCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        var params:[String:String] = [:]
        if customParams != nil {
            params["key"] = customParams!.keys.joined(separator: ",")
            params["value"] = customParams!.values.joined(separator: ",")
        }
        PBRestController.request(.get, endPoint: playerEndPointWithPath("\(playerId)/action/\(actionName)/count"), parameters: params as [String : AnyObject], completionBlock: { (response) in
            if let json:[String:AnyObject] = response.parsedJson as? [String:AnyObject], let actionJson:[String:AnyObject] = json["action"] as? [String:AnyObject], let count:Int = actionJson["count"] as? Int {
                completionBlock(actionJson["action_id"] as? String, count)
            }
            else {
                failureBlock(PBError(message: "Unknown error"))
            }
            }, failureBlock: failureBlock)
    }

    // MARK: - Private
    
    fileprivate class func updateMainData(_ registerForm:PBRegisterForm, completionBlock:@escaping PBPlayerCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        PBRestController.request(.post, endPoint: playerEndPointWithPath("\(registerForm.playerId!)/register"), parameters: registerForm.params() as [String : AnyObject], completionBlock: { (apiResponse) in
            let player:PBPlayer = PBPlayer(registerForm:registerForm)
            completionBlock(player)
            }, failureBlock:failureBlock)
    }
    
    fileprivate class func postProfilePicture(_ picture:UIImage?, completionBlock:@escaping (_ imageUrl:String?) -> Void, failureBlock:@escaping PBFailureErrorBlock) {
        if picture == nil {
            completionBlock(nil)
            return
        }
        let profilePictureData:Data = UIImageJPEGRepresentation(picture!, 0.7)!
        PBRestController.uploadData(profilePictureData, endPoint: "File/upload", parameters: nil, completionBlock: { (response) in
            if let json = response.parsedJson {
                completionBlock(json["url"] as? String)
            }
            }, failureBlock: failureBlock)
    }
    
}

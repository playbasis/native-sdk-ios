//
//  PBQuestApi.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/20/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

class PBQuestApi: PBBaseApi {
    private class func questEndPointWithPath(path:String) -> String {
        return PBEndPoint.QUEST_END_POINT + path
    }
    
  
    
    class func  getQuestList(completionBlock:PBQuestsCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.GET, endPoint: questEndPointWithPath(""), parameters: nil, completionBlock: { (response) in
            let quests:[PBQuest] = PBQuest.pbQuestFromApiResponse(response)
            completionBlock(quests)
            debugPrint(response)
            }, failureBlock:failureBlock)
    }
    
    class func  getQuestListAvailableForPlayerWithPlayerId(playerId:String, completionBlock:PBQuestsCompletionBlock, failureBlock:PBFailureErrorBlock){
        let params:[String:String] = ["player_id" : playerId]
        PBRestController.request(.GET, endPoint: questEndPointWithPath("available"), parameters: params, completionBlock: { (response) in
            let quests:[PBQuest] = PBQuest.pbQuestFromApiResponse(response)
            debugPrint(response)
            completionBlock(quests)
        }, failureBlock:failureBlock)
    }
    
    class func  getQuestInfoWithQuestId(questId:String, completionBlock:PBQuestCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.GET, endPoint: questEndPointWithPath(questId), parameters: nil, completionBlock: { (response) in
            let quest:PBQuest = PBQuest(apiResponse:response)
            completionBlock(quest)
            }, failureBlock:failureBlock)
    }
    
    
    class func  joinQuestInfoWithQuestIdAndPlayerId(questId:String,playerId:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock){
        let params:[String:String] = ["player_id":playerId]
        PBRestController.request(.POST, endPoint: questEndPointWithPath("\(questId)/join"), parameters: params, completionBlock: { (response) in
            completionBlock()
        }, failureBlock:failureBlock)
    }
    
    class func  cancelQuestInfoWithQuestIdAndPlayerId(questId:String,playerId:String, completionBlock:PBEmptyCompletionBlock, failureBlock:PBFailureErrorBlock){
        let params:[String:String] = ["player_id":playerId]
        PBRestController.request(.POST, endPoint: questEndPointWithPath("\(questId)/cancel"), parameters: params, completionBlock: { (response) in
            completionBlock()
        }, failureBlock:failureBlock)
    }
    
    
    class func getQuestLeaderBoardWithForm(leaderBoardForm:PBLeaderBoardForm, completionBlock:PBLeaderBoardCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.GET, endPoint: questEndPointWithPath("leader"), parameters: leaderBoardForm.params(), completionBlock: { (response) in
            let parsedLeaderboard = PBLeaderBoard.pbLeaderBoardDataFromApiResponse(response)
            completionBlock(leadearBoard: parsedLeaderboard.leaderBoardList, playerData: parsedLeaderboard.playerData)
        }, failureBlock: failureBlock)
    }
}

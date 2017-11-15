//
//  PBQuestApi.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/20/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

open class PBQuestApi: PBBaseApi {
    
    fileprivate class func questEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.QUEST_END_POINT + self.encodePath(path)
    }
    
    open class func getQuestList(_ completionBlock:@escaping sPBQuestsCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        PBRestController.request(.get, endPoint: questEndPointWithPath(""), parameters: nil, completionBlock: { (response) in
            let quests:[PBQuest] = PBQuest.pbQuestFromApiResponse(response)
            completionBlock(quests)
            debugPrint(response)
            }, failureBlock:failureBlock)
    }
    
    open class func getQuestListAvailableForPlayerWithPlayerId(_ playerId:String, completionBlock:@escaping PBQuestsCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        let params:[String:String] = ["player_id" : playerId]
        PBRestController.request(.get, endPoint: questEndPointWithPath("available"), parameters: params, completionBlock: { (response) in
            let quests:[PBQuest] = PBQuest.pbQuestFromApiResponse(response)
            debugPrint(response)
            completionBlock(quests)
        }, failureBlock:failureBlock)
    }
    
    open class func getQuestInfoWithQuestId(_ questId:String, completionBlock:@escaping PBQuestCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        PBRestController.request(.get, endPoint: questEndPointWithPath(questId), parameters: nil, completionBlock: { (response) in
            let quest:PBQuest = PBQuest(apiResponse:response)
            completionBlock(quest)
            }, failureBlock:failureBlock)
    }
    
    
    open class func joinQuestInfoWithQuestIdAndPlayerId(_ questId:String,playerId:String, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        let params:[String:String] = ["player_id":playerId]
        PBRestController.request(.post, endPoint: questEndPointWithPath("\(questId)/join"), parameters: params, completionBlock: { (response) in
            completionBlock()
        }, failureBlock:failureBlock)
    }
    
    open class func cancelQuestInfoWithQuestIdAndPlayerId(_ questId:String,playerId:String, completionBlock:@escaping PBEmptyCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        let params:[String:String] = ["player_id":playerId]
        PBRestController.request(.post, endPoint: questEndPointWithPath("\(questId)/cancel"), parameters: params, completionBlock: { (response) in
            completionBlock()
        }, failureBlock:failureBlock)
    }
    
    
    open class func getQuestLeaderBoardWithForm(_ leaderBoardForm:PBLeaderBoardForm, completionBlock:@escaping PBLeaderBoardCompletionBlock, failureBlock:@escaping PBFailureErrorBlock){
        PBRestController.request(.get, endPoint: questEndPointWithPath("leader"), parameters: leaderBoardForm.params(), completionBlock: { (response) in
            let parsedLeaderboard = PBLeaderBoard.pbLeaderBoardDataFromApiResponse(response)
            completionBlock(leadearBoard: parsedLeaderboard.leaderBoardList, playerData: parsedLeaderboard.playerData)
        }, failureBlock: failureBlock)
    }
}

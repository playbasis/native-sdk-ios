//
//  PBLeaderBoardForm.swift
//  Playbook
//
//  Created by Médéric Petit on 6/24/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

public enum PBLeaderBoardStatus:String {
    case Join = "join"
    case Finish = "finish"
}

public final class PBLeaderBoardForm: PBForm {
    
    //Required
    var questId:String!
    
    // Optional
    var completionElementId:String?
    var playerId:String?
    var offset:Int? = 0
    var limit:Int? = 20
    var status:PBLeaderBoardStatus?
    
    override public func params() -> [String:String] {
        var params:[String:String] = [:]
        params["quest_id"] = questId!

        if let mCompletionElementId = self.completionElementId {
            params["completion_element_id"] = mCompletionElementId
        }
        if let mPlayedId = self.playerId {
            params["player_id"] = mPlayedId
        }
        if let mOffset = self.offset {
            params["offset"] = String(mOffset)
        }
        if let mLimit = self.limit {
            params["limit"] = String(mLimit)
        }
        if let mStatus = self.status {
            params["status"] = mStatus.rawValue
        }

        
        
        return params
    }
    
}

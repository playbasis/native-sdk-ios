//
//  PBRecentActivityForm.swift
//  Pods
//
//  Created by Médéric Petit on 9/20/2559 BE.
//
//

import UIKit

public enum PBRecentActivityMode:String {
    case All = "all"
    case Player = "player"
}

open class PBRecentActivityForm: PBForm {
    
    // Optional
    
    open var playerId:String?
    open var offset:Int? = 0
    open var limit:Int? = 20
    open var lastReadActivityId:String?
    open var mode:PBRecentActivityMode = .All
    open var eventType:String?
    open var actionName:String?
    
    override open func params() -> [String : String] {
        var params:[String:String] = [:]
        params["mode"] = self.mode.rawValue
        
        if let mPlayerId = self.playerId {
            params["player_id"] = mPlayerId
        }
        if let mOffset = self.offset {
            params["offset"] = String(mOffset)
        }
        if let mLimit = self.limit {
            params["limit"] = String(mLimit)
        }
        if let mLastReadActivityId = self.lastReadActivityId {
            params["last_read_activity_id"] = mLastReadActivityId
        }
        if let mEventType = self.eventType {
            params["event_type"] = mEventType
        }
        if let mActionName = self.actionName {
            params["action_name"] = mActionName
        }
        return params
    }

}

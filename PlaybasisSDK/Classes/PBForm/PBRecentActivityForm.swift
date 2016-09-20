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

public class PBRecentActivityForm: PBForm {
    
    // Optional
    
    public var playerId:String?
    public var offset:Int? = 0
    public var limit:Int? = 20
    public var lastReadActivityId:String?
    public var mode:PBRecentActivityMode = .All
    public var eventType:String?
    
    override public func params() -> [String : String] {
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
        return params
    }

}

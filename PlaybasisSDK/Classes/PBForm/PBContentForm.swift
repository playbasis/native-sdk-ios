//
//  PBContentForm.swift
//  WomensRun
//
//  Created by Médéric Petit on 8/4/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

public enum PBSortContent:String {
    case Title = "title"
    case DateStart = "date_start"
    case DateEnd = "date_end"
    case DateAdded = "date_added"
    case DateModified = "date_modified"
    case Random = "random"
    case Followup = "followup"
    case Action = "action"
}

public final class PBContentForm: PBForm {
    
    //Required
    public var dateCheck:Bool! = true
    public var sort:PBSortContent! = .Title
    public var order:String! = "asc"
    public var fullHtml:Bool! = false
    
    
    // Optional
    public var nodeId:String?
    public var title:String?
    public var category:String?
    public var offset:Int? = 0
    public var limit:Int? = 100
    public var pin:String?
    public var tags:String?
    public var status:String?
    public var playerId:String?
    public var onlyNewContent:Bool?
    public var onlyNewFeedback:Bool?
    
    
    override public func params() -> [String:String] {
        var params:[String:String] = [:]
        params["date_check"] = String(dateCheck)
        params["sort"] = sort.rawValue
        params["order"] = order
        params["full_html"] = String(fullHtml)
        
        if let mOnlyNewContent = self.onlyNewContent {
            params["only_new_content"] = String(mOnlyNewContent)
        }
        if let mOnlyNewFeedback = self.onlyNewFeedback {
            params["only_new_feedback"] = String(mOnlyNewFeedback)
        }
        if let mNodeId = self.nodeId {
            params["node_id"] = mNodeId
        }
        if let mTitle = self.title {
            params["title"] = mTitle
        }
        if let mCategory = self.category {
            params["category"] = String(mCategory)
        }
        if let mOffset = self.offset {
            params["offset"] = String(mOffset)
        }
        if let mLimit = self.limit {
            params["limit"] = String(mLimit)
        }
        if let mPin = self.pin {
            params["pin"] = String(mPin)
        }
        if let mTags = self.tags {
            params["tags"] = String(mTags)
        }
        if let mStatus = self.status {
            params["status"] = mStatus
        }
        if let mPlayerId = self.playerId {
            params["player_id"] = String(mPlayerId)
        }
        return params
    }
}

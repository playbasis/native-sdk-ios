//
//  PBGameForm.swift
//  Pods
//
//  Created by Mederic PETIT on 11/14/16.
//
//

import UIKit

public class PBGameForm: PBForm {
    
    public var gameName:String?
    public var stageLevel:String?
    public var stageName:String?
    
    
    public var sort:String?
    public var order:String?
    public var offset:Int? = 0
    public var limit:Int? = 100
    public var tags:String?
    public var status:Bool = true
    
    
    override public func params() -> [String:String] {
        //  guard isValid() else { return  nil }
        var params:[String:String] = [:]
        params["status"] = String(status)
        
        if let mGameName = self.gameName {
            params["game_name"] = mGameName
        }
        if let mStageLevel = self.stageLevel {
            params["stage_level"] = mStageLevel
        }
        if let mStageName = self.stageName {
            params["stage_name"] = mStageName
        }
        if let mSort = self.sort {
            params["sort"] = mSort
        }
        if let mOrder = self.order {
            params["order"] = mOrder
        }
        if let mOffset = self.offset {
            params["offset"] = String(mOffset)
        }
        if let mLimit = self.limit {
            params["limit"] = String(mLimit)
        }
        if let mTags = self.tags {
            params["tags"] = mTags
        }
        return params
    }

}

//
//  PBGameForm.swift
//  Pods
//
//  Created by Mederic PETIT on 11/14/16.
//
//

import UIKit

open class PBGameForm: PBForm {
    
    open var gameName:String?
    open var stageLevel:String?
    open var stageName:String?
    
    
    open var sort:String?
    open var order:String?
    open var offset:Int? = 0
    open var limit:Int? = 100
    open var tags:String?
    open var status:Bool = true
    
    
    override open func params() -> [String:String] {
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

//
//  PBGameSetting.swift
//  Pods
//
//  Created by Mederic PETIT on 11/14/16.
//
//

import UIKit
import ObjectMapper

open class PBGameSetting: PBModel {
    
    open var gameName:String! = ""
    open var image:String! = ""
    open var duration:String! = ""
    open var actionTime:String! = ""
    open var stage:[PBGameStageSetting] = []
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        gameName <- map["game_name"]
        image <- map["image"]
        duration <- map["duration"]
        actionTime <- map["action_time"]
        stage <- map["stage"]
    }
    
    
    class func pbGameSettingsFromApiResponse(_ apiResponse:PBApiResponse) -> [PBGameSetting] {
        return Mapper<PBGameSetting>().mapArray(apiResponse.parsedJson!) ?? []
    }

}

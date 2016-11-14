//
//  PBGameSetting.swift
//  Pods
//
//  Created by Mederic PETIT on 11/14/16.
//
//

import UIKit
import ObjectMapper

public class PBGameSetting: PBModel {
    
    public var gameName:String! = ""
    public var image:String! = ""
    public var duration:String! = ""
    public var actionTime:String! = ""
    public var stage:[PBGameStageSetting] = []
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        gameName <- map["game_name"]
        image <- map["image"]
        duration <- map["duration"]
        actionTime <- map["action_time"]
        stage <- map["stage"]
    }
    
    
    class func pbGameSettingsFromApiResponse(apiResponse:PBApiResponse) -> [PBGameSetting] {
        return Mapper<PBGameSetting>().mapArray(apiResponse.parsedJson!) ?? []
    }

}

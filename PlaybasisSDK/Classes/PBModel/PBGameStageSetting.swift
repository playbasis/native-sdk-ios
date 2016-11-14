//
//  PBGameStageSetting.swift
//  Pods
//
//  Created by Mederic PETIT on 11/14/16.
//
//

import UIKit
import ObjectMapper

public class PBGameStageSetting: PBModel {
    
    public var stageName:String! = ""
    public var stageLevel:Int! = 1
    public var image:String! = ""
    public var rangeLow:Int! = 0
    public var rangeHigh:Int! = 0
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        stageName <- map["stage_name"]
        stageLevel <- map["stage_level"]
        image <- map["image"]
        rangeLow <- map["range_low"]
        rangeHigh <- map["range_high"]
    }
    
    
    class func pbGameStageSettingsFromApiResponse(apiResponse:PBApiResponse) -> [PBGameStageSetting] {
        return Mapper<PBGameStageSetting>().mapArray(apiResponse.parsedJson!) ?? []
    }
    

}

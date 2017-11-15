//
//  PBGameStageSetting.swift
//  Pods
//
//  Created by Mederic PETIT on 11/14/16.
//
//

import UIKit
import ObjectMapper

open class PBGameStageSetting: PBModel {
    
    open var stageName:String! = ""
    open var stageLevel:Int! = 1
    open var image:String! = ""
    open var rangeLow:Int! = 0
    open var rangeHigh:Int! = 0
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        stageName <- map["stage_name"]
        stageLevel <- map["stage_level"]
        image <- map["image"]
        rangeLow <- map["range_low"]
        rangeHigh <- map["range_high"]
    }
    
    
    class func pbGameStageSettingsFromApiResponse(_ apiResponse:PBApiResponse) -> [PBGameStageSetting] {
        return Mapper<PBGameStageSetting>().mapArray(JSONObject: apiResponse.parsedJson!) ?? []
    }
    

}

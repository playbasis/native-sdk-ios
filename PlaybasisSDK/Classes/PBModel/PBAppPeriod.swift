//
//  PBAppPeriod.swift
//  Pods
//
//  Created by Mederic PETIT on 10/14/16.
//
//

import UIKit
import ObjectMapper

public class PBAppPeriod: PBModel {
    
    var dateStart:NSDate?
    var dateEnd:NSDate?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        dateStart <- (map["date_start"], ISO8601DateTransform())
        dateEnd <- (map["date_end"], ISO8601DateTransform())
    }
    
    public init(appPeriodJson:[String:String]) {
        super.init()
        Mapper<PBAppPeriod>().map(appPeriodJson, toObject: self)
    }

}

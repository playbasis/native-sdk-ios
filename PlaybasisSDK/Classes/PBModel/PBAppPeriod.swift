//
//  PBAppPeriod.swift
//  Pods
//
//  Created by Mederic PETIT on 10/14/16.
//
//

import UIKit
import ObjectMapper

open class PBAppPeriod: PBModel {
    
    var dateStart:Date?
    var dateEnd:Date?
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        dateStart <- (map["date_start"], ISO8601DateTransform())
        dateEnd <- (map["date_end"], ISO8601DateTransform())
    }
    
    public init(appPeriodJson:[String:String]) {
        super.init()
        _ = Mapper<PBAppPeriod>().map(JSON: appPeriodJson as [String : Any], toObject: self)
    }
}

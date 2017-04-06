//
//  PBRecentActivityAction.swift
//  Pods
//
//  Created by Médéric Petit on 9/20/2559 BE.
//
//

import UIKit
import ObjectMapper

open class PBRecentActivityAction: PBRecentActivity {
    
    open var playerId2:String?
    open var url:String?
    open var stringFilter:String?
    open var parameters:[String:String]?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override open func mapping(_ map: Map) {
        super.mapping(map)
        playerId2 <- map["pb_player_id-2"]
        url <- map["message"]
        stringFilter <- map["string_filter"]
        parameters <- map["parameters"]
    }


}

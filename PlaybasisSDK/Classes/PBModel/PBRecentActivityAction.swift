//
//  PBRecentActivityAction.swift
//  Pods
//
//  Created by Médéric Petit on 9/20/2559 BE.
//
//

import UIKit
import ObjectMapper

public class PBRecentActivityAction: PBRecentActivity {
    
    public var playerId2:String?
    public var url:String?
    public var stringFilter:String?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        playerId2 <- map["pb_player_id-2"]
        url <- map["message"]
        stringFilter <- map["string_filter"]
    }


}

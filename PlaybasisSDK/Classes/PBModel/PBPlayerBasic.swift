//
//  PBPlayerBasic.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/24/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBPlayerBasic: PBModel {
    public var playerId:String! = ""
    public var imageURL:String! = ""
    public var username:String! = ""
    public var firstName:String! = ""
    public var lastName:String! = ""
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        self.playerId <- map["cl_player_id"]
        self.imageURL <- map["image"]
        self.username <- map["username"]
        self.firstName <- map["first_name"]
        self.lastName <- map["last_name"]
        
    }
    
    func getFullName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
}

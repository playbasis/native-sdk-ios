//
//  PBPlayerBasic.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/24/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBPlayerBasic: PBModel {
    open var playerId:String! = ""
    open var imageURL:String! = ""
    open var username:String! = ""
    open var firstName:String! = ""
    open var lastName:String! = ""
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
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

//
//  PBPlayerBasic.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/24/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

class PBPlayerBasic: PBModel {
    var playerId:String! = ""
    var imageURL:String! = ""
    var username:String! = ""
    var firstName:String! = ""
    var lastName:String! = ""
    
    
    override func mapping(map: Map) {
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

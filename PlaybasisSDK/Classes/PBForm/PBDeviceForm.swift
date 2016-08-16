//
//  PBDeviceForm.swift
//  Playbook
//
//  Created by Médéric Petit on 8/15/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

class PBDeviceForm: PBForm {

    //Required
    var playerId:String!
    var deviceToken:String!
    var deviceDescription:String!
    var deviceName:String!
    
    override func params() -> [String:String] {
        var params:[String:String] = [:]
        params["player_id"] = playerId
        params["device_token"] = deviceToken
        params["device_description"] = deviceDescription
        params["device_name"] = deviceName
        params["os_type"] = "iOS"
        return params
    }
    
}

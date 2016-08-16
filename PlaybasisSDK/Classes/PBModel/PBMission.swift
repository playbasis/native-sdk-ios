//
//  PBMission.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/20/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBMission: PBModel {

    var name:String?
    var number:String?
    var desc:String?
    var hint:String?
    var imageURL:String?
    var missionId:String?
    var status:String?
    var completion:[PBCompletion] = []
    var pending:[PBPending] = []

    override public func mapping(map: Map) {
        super.mapping(map)
        name   <- map["mission_name"]
        number <- map["mission_number"]
        desc   <- map["description"]
        hint   <- map["hint"]
        imageURL   <- map["image"]
        missionId   <- map["mission_id"]
        completion   <- map["completion"]
        pending  <- map["pending"]
    }
}

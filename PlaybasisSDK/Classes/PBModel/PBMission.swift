//
//  PBMission.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/20/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBMission: PBModel {

    open var name:String?
    open var number:String?
    open var desc:String?
    open var hint:String?
    open var imageURL:String?
    open var missionId:String?
    open var status:String?
    open var completion:[PBCompletion] = []
    open var pending:[PBPending] = []
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }

    override open func mapping(_ map: Map) {
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

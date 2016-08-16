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

    public var name:String?
    public var number:String?
    public var desc:String?
    public var hint:String?
    public var imageURL:String?
    public var missionId:String?
    public var status:String?
    public var completion:[PBCompletion] = []
    public var pending:[PBPending] = []
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }

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

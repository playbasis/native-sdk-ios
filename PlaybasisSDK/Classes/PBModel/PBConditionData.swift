//
//  PBConditionData.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/22/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBConditionData: PBModel {

    public var questName:String?
    public var desc:String?
    public var hint:String?
    public var imageURL:String?
  
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        questName <- map["quest_name"]
        desc <- map["description"]
        hint <- map["hint"]
        imageURL <- map["image"]
    }

}

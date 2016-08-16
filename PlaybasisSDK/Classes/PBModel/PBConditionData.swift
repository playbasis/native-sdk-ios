//
//  PBConditionData.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/22/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

class PBConditionData: PBModel {

    var questName:String?
    var desc:String?
    var hint:String?
    var imageURL:String?
  
    
    override func mapping(map: Map) {
        super.mapping(map)
        questName <- map["quest_name"]
        desc <- map["description"]
        hint <- map["hint"]
        imageURL <- map["image"]
    }

}

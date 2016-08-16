//
//  PBIncomplete.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/23/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBIncomplete: PBModel {


    var incompletionId:String?
    var type:String?
    var value:Int?
    var elementId:String?
    var filter:String?
    
    override public func mapping(map: Map) {
        super.mapping(map)
        incompletionId <- map["incompletion_id"]
        type <- map["incompletion_type"]
        value <- map["incompletion_value"]
        elementId <- map["incompletion_element_id"]
        filter <- map["incompletion_filter"]
        
    }
}

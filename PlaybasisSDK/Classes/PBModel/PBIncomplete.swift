//
//  PBIncomplete.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/23/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBIncomplete: PBModel {


    open var incompletionId:String?
    open var type:String?
    open var value:Int?
    open var elementId:String?
    open var filter:String?
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        incompletionId <- map["incompletion_id"]
        type <- map["incompletion_type"]
        value <- map["incompletion_value"]
        elementId <- map["incompletion_element_id"]
        filter <- map["incompletion_filter"]
        
    }
}

//
//  PBReportValue.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 8/16/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBReportValue: PBModel {
    
    open var quantity:Int = 0
    open var previousQuantity:Int = 0
    open var percentChanged:Int = 0
    
    public override init() {
        super.init()
    }
    
    public required init?(_ map: Map) {
        super.init(map)
    }
    
    open override func mapping(_ map: Map) {
        super.mapping(map)
        quantity <- map["quantity"]
        previousQuantity <- map["previous_quantity"]
        percentChanged <- map["percent_changed"]
    }
    
    
}

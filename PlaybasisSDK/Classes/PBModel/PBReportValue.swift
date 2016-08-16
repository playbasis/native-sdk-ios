//
//  PBReportValue.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 8/16/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBReportValue: PBModel {
    
    public var quantity:Int = 0
    public var previousQuantity:Int = 0
    public var percentChanged:Int = 0
    
    public override init() {
        super.init()
    }
    
    public required init?(_ map: Map) {
        super.init(map)
    }
    
    public override func mapping(map: Map) {
        super.mapping(map)
        quantity <- map["quantity"]
        previousQuantity <- map["previous_quantity"]
        percentChanged <- map["percent_changed"]
    }
    
    
}

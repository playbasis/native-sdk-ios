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


    public var incompletionId:String?
    public var type:String?
    public var value:Int?
    public var elementId:String?
    public var filter:String?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        incompletionId <- map["incompletion_id"]
        type <- map["incompletion_type"]
        value <- map["incompletion_value"]
        elementId <- map["incompletion_element_id"]
        filter <- map["incompletion_filter"]
        
    }
}

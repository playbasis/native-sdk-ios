//
//  PBModel.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/20/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBModel: NSObject, Mappable{

    open var uid:String?
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map){
    }
    
    open func mapping(map: Map) {
        uid <- map["_id"]
    }

}

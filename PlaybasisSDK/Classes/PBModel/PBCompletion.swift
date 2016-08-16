//
//  PBCompletion.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/21/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBCompletion: PBModel {

    public var title:String! = ""
    public var type:String! = ""
    public var value:String! = ""
    public var filter:String?
    public var elementId:String?
    public var missionId:String?
    public var completionOp:String?
    public var completionId:String?
    public var completionData:PBCompletionData?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        completionOp <- map["completion_op"]
        completionId <- map["completion_id"]
        title <- map["completion_title"]
        type <- map["completion_type"]
        value <- map["completion_value"]
        filter <- map["completion_filter"]
        elementId <- map["completion_element_id"]
        missionId <- map["mission_id"]
        completionData <- map["completion_data"]
    
    }
}

//
//  PBContent.swift
//  Playbook
//
//  Created by Orawan Manasombun on 6/29/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBContent: PBModel {
    
    open var title:String! = ""
    open var detail:String! = ""
    open var imageURL:String! = ""
    open var category:String! = ""
    open var summary:String! = ""
    open var date:Date?
    
    public override init() {
        super.init()
    }
    
    init(apiResponse:PBApiResponse) {
        super.init()
        _ = Mapper<PBContent>().map(JSONObject: apiResponse.parsedJson!["result"] as Any, toObject: self)
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        title <- map["title"]
        detail <- map["detail"]
        imageURL <- map["image"]
        category <- map["category"]
        date <- (map["date_start"],ISO8601DateTransform())
        summary <- map["summary"]
    }
    
    class func pbContentFromApiResponse(_ apiResponse:PBApiResponse) -> [PBContent] {
        var contentList:[PBContent] = []
        contentList = Mapper<PBContent>().mapArray(JSONObject: apiResponse.parsedJson!["result"] as Any)!
        return contentList
    }
    
}

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
        Mapper<PBContent>().map(apiResponse.parsedJson!["result"], toObject: self)
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    
    override open func mapping(_ map: Map) {
        super.mapping(map)
        title <- map["title"]
        detail <- map["detail"]
        imageURL <- map["image"]
        category <- map["category"]
        date <- (map["date_start"],ISO8601DateTransform())
        summary <- map["summary"]
    }
    
    class func pbContentFromApiResponse(_ apiResponse:PBApiResponse) -> [PBContent] {
        var contentList:[PBContent] = []
        contentList = Mapper<PBContent>().mapArray(apiResponse.parsedJson!["result"])!
        return contentList
    }
    
}

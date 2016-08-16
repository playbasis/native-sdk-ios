//
//  PBContent.swift
//  Playbook
//
//  Created by Orawan Manasombun on 6/29/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

public class PBContent: PBModel {
    
    var title:String! = ""
    var detail:String! = ""
    var imageURL:String! = ""
    var category:String! = ""
    var summary:String! = ""
    var date:NSDate?
    
    override init() {
        super.init()
    }
    
    init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBContent>().map(apiResponse.parsedJson!["result"], toObject: self)
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    
    override public func mapping(map: Map) {
        super.mapping(map)
        title <- map["title"]
        detail <- map["detail"]
        imageURL <- map["image"]
        category <- map["category"]
        date <- (map["date_start"],ISO8601DateTransform())
        summary <- map["summary"]
    }
    
    class func pbContentFromApiResponse(apiResponse:PBApiResponse) -> [PBContent] {
        var contentList:[PBContent] = []
        contentList = Mapper<PBContent>().mapArray(apiResponse.parsedJson!["result"])!
        return contentList
    }
    
}

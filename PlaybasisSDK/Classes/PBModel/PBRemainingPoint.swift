//
//  PBRemainingPoint.swift
//  Pods
//
//  Created by Mederic PETIT on 11/14/16.
//
//

import UIKit
import ObjectMapper

public class PBRemainingPoint: PBModel {
    
    public var name:String! = ""
    public var quantity:Int! = 0
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        name <- map["name"]
        quantity <- map["quantity"]
    }
    
    
    class func pbRemainingPointFromPointsApiResponse(apiResponse:PBApiResponse) -> [PBRemainingPoint] {
        return Mapper<PBRemainingPoint>().mapArray(apiResponse.parsedJson!) ?? []
        }
}

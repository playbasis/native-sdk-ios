//
//  PBRemainingPoint.swift
//  Pods
//
//  Created by Mederic PETIT on 11/14/16.
//
//

import UIKit
import ObjectMapper

open class PBRemainingPoint: PBModel {
    
    open var name:String! = ""
    open var quantity:Int! = 0
    
    public override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        quantity <- map["quantity"]
    }
    
    
    class func pbRemainingPointFromPointsApiResponse(_ apiResponse:PBApiResponse) -> [PBRemainingPoint] {
        return Mapper<PBRemainingPoint>().mapArray(apiResponse.parsedJson!) ?? []
        }
}

//
//  PBActionReport.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 8/16/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper


public class PBActionReport: PBModel {
    
    public var year:String! = ""
    public var value:[PBMonthReportValue] = []

    public override init() {
        super.init()
    }
    
    public required init?(_ map: Map) {
        super.init(map)
    }

    
    public class func pbActionReportFromApiResponse(apiResponse:PBApiResponse) -> [PBActionReport] {
        var actionReportList:[PBActionReport] = []
        if let responseObject:[String:AnyObject] = (apiResponse.parsedJson as? [String:AnyObject]){
            
            if let allKey:[String] = Array(responseObject.keys) {
                for key in allKey {
                    if let reportValue:[String : AnyObject] = responseObject[key]  as? [String:AnyObject] {
                       let report = PBActionReport()
                       report.year = key
                       report.value = PBMonthReportValue.pbMonthReportValueReportFromDictionary(reportValue)
                       actionReportList.append(report)
                    }
                }
            }
            
        }
        return actionReportList
    }
    
    
}

//
//  PBMonthReportValue.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 8/16/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit
import ObjectMapper

open class PBMonthReportValue: PBModel {
    
    open var month:String! = ""
    open var reportValue:PBReportValue?
    
    public override init() {
        super.init()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    
    open class func pbMonthReportValueReportFromDictionary(_ dictionnary:[String:AnyObject]) -> [PBMonthReportValue] {
        var monthReportValueList:[PBMonthReportValue] = []
        
        if let responseObject:[String:AnyObject] = dictionnary {
            if let allKey:[String] = Array(responseObject.keys) {
                for key in allKey {
                    
                    print("month: \(key)    quantity: \(String(responseObject[key]!["quantity"]!))")

                    if let reportValue:[String:AnyObject] = responseObject[key] as? [String:AnyObject]{
                        let report = PBMonthReportValue()
                        report.month = key
                        //print("month: \(key)    quantity: \(String(reportValue["quantity"]!))")
                        
                        report.reportValue = Mapper<PBReportValue>().map(reportValue)
                        
                        monthReportValueList.append(report)
                    }
                }
            }
            
        }
        return monthReportValueList
    }


}

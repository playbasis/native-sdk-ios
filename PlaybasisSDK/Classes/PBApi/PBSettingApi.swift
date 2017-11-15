//
//  PBSettingApi.swift
//  Pods
//
//  Created by Mederic PETIT on 10/14/16.
//
//

import UIKit

open class PBSettingApi: PBBaseApi {
    
    fileprivate class func settingEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.SETTING_END_POINT + self.encodePath(path)
    }
    
    open class func getAppStatusWithCompletionBlock(_ completionBlock:@escaping PBAppStatusCompletionBlock, failureBlock:@escaping PBFailureErrorBlock) {
        PBRestController.request(.get, endPoint: settingEndPointWithPath("appStatus"), completionBlock: { (apiResponse) in
            if let json:[String:AnyObject] = apiResponse.parsedJson as? [String:AnyObject] {
                var appPeriod:PBAppPeriod?
                if let appPeriodJson:[String:String] = json["app_period"] as? [String:String] {
                    appPeriod = PBAppPeriod(appPeriodJson: appPeriodJson)
                }
                completionBlock(json["app_status"] as? Bool ?? false, appPeriod)
            }
            else {
                failureBlock(PBError(message: "Unknown error"))
            }
            }, failureBlock:failureBlock)
    }

}

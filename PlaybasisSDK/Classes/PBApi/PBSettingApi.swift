//
//  PBSettingApi.swift
//  Pods
//
//  Created by Mederic PETIT on 10/14/16.
//
//

import UIKit

public class PBSettingApi: PBBaseApi {
    
    private class func settingEndPointWithPath(path:String) -> String {
        return PBEndPoint.SETTING_END_POINT + self.encodePath(path)
    }
    
    public class func getAppStatusWithCompletionBlock(completionBlock:PBAppStatusCompletionBlock, failureBlock:PBFailureErrorBlock) {
        PBRestController.request(.GET, endPoint: settingEndPointWithPath("appStatus"), parameters: nil, completionBlock: { (apiResponse) in
            if let json:[String:AnyObject] = apiResponse.parsedJson as? [String:AnyObject] {
                var appPeriod:PBAppPeriod?
                if let appPeriodJson:[String:String] = json["app_period"] as? [String:String] {
                    appPeriod = PBAppPeriod(appPeriodJson: appPeriodJson)
                }
                completionBlock(appStatus: json["app_status"] as? Bool ?? false, appPeriod: appPeriod)
            }
            else {
                failureBlock(error: PBError(message: "Unknown error"))
            }
            }, failureBlock:failureBlock)
    }

}

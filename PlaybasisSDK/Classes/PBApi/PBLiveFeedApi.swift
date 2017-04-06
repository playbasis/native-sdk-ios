//
//  PBLiveFeedApi.swift
//  Pods
//
//  Created by Médéric Petit on 9/20/2559 BE.
//
//

import UIKit

open class PBLiveFeedApi: PBBaseApi {

    fileprivate class func liveFeedEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.LIVE_FEED_END_POINT + self.encodePath(path)
    }
    
    open class func getRecentActivitiesWithForm(_ recentActivityForm:PBRecentActivityForm, completionBlock:PBRecentActivitiesCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.GET, endPoint: liveFeedEndPointWithPath("recentActivities"), parameters: recentActivityForm.params(), completionBlock: { (response) in
            let recentActivities:[PBRecentActivity] = PBRecentActivity.pbRecentActivitiesFromApiResponse(response)
            completionBlock(activities: recentActivities)
            }, failureBlock: failureBlock)
    }
    
}

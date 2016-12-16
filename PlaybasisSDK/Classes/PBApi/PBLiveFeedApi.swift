//
//  PBLiveFeedApi.swift
//  Pods
//
//  Created by Médéric Petit on 9/20/2559 BE.
//
//

import UIKit

public class PBLiveFeedApi: PBBaseApi {

    private class func liveFeedEndPointWithPath(path:String) -> String {
        return PBEndPoint.LIVE_FEED_END_POINT + self.encodePath(path)
    }
    
    public class func getRecentActivitiesWithForm(recentActivityForm:PBRecentActivityForm, completionBlock:PBRecentActivitiesCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.GET, endPoint: liveFeedEndPointWithPath("recentActivities"), parameters: recentActivityForm.params(), completionBlock: { (response) in
            let recentActivities:[PBRecentActivity] = PBRecentActivity.pbRecentActivitiesFromApiResponse(response)
            completionBlock(activities: recentActivities)
            }, failureBlock: failureBlock)
    }
    
}

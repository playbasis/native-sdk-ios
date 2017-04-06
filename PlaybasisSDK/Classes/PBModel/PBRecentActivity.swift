//
//  PBRecentActivity.swift
//  Pods
//
//  Created by Médéric Petit on 9/20/2559 BE.
//
//

import UIKit
import ObjectMapper

public enum PBRecentActivityEventType:String {
    case Redeem = "REDEEM"
    case Action = "ACTION"
    case Reward = "REWARD"
    case Level = "LEVEL"
    case Other = "OTHER"
}

open class PBRecentActivity: PBModel {
    
    open var eventType:PBRecentActivityEventType = .Other
    open var actionName:String!
    open var actionIcon:String?
    open var player:PBPlayer?
    open var dateAdded:Date?
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override open func mapping(_ map: Map) {
        super.mapping(map)
        eventType <- (map["event_type"], EnumTransform<PBRecentActivityEventType>())
        actionName <- map["action_name"]
        actionIcon <- map["action_icon"]
        player <- map["player"]
        dateAdded <- (map["date_added"], ISO8601DateTransform())
        uid <- map["id"]
    }
    
    class func pbRecentActivitiesFromApiResponse(_ apiResponse:PBApiResponse) -> [PBRecentActivity] {
        var recentActivities:[PBRecentActivity] = []
        if let activities:[[String:AnyObject]] = apiResponse.parsedJson!["activities"] as? [[String:AnyObject]] {
            activities.forEach({
                switch PBRecentActivityEventType(rawValue:($0["event_type"] as! String))! {
                case .Redeem:
                    recentActivities.append(Mapper<PBRecentActivityRedeem>().map($0)!)
                case .Action:
                    recentActivities.append(Mapper<PBRecentActivityAction>().map($0)!)
                case .Reward:
                    recentActivities.append(Mapper<PBRecentActivityReward>().map($0)!)
                case .Level:
                    break
                case .Other:
                    break
                }
            })
        }
        return recentActivities
    }
}

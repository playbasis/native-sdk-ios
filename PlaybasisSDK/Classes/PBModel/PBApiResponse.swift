//
//  ApiResponse.swift
//  Idea
//
//  Created by Médéric Petit on 4/20/2559 BE.
//  Copyright © 2559 playbasis. All rights reserved.
//

import Alamofire
import ObjectMapper

public typealias PBFailureErrorBlock = (_ error:PBError) -> Void

public typealias PBEmptyCompletionBlock = () -> Void

typealias PBAuthenticationCompletionBlock = (_ authenticationToken:PBAuthenticationToken) -> Void

public typealias PBPlayerCompletionBlock = (_ player:PBPlayer) -> Void

public typealias PBPlayerCustomFieldsCompletionBlock = (_ customFields:[String:String]) -> Void

public typealias PBPlayerAuthCompletionBlock = (_ playerId:String) -> Void

public typealias PBPlayerBadgesCompletionBlock = ([PBBadge]) -> Void

public typealias PBQuestCompletionBlock = (PBQuest) -> Void

public typealias PBQuestsCompletionBlock = ([PBQuest]) -> Void

public typealias PBGoodsCompletionBlock = ([PBRewardData]) -> Void

public typealias PBRewardsCompletionBlock = ([PBReward]) -> Void

public typealias PBPointsCompletionBlock = ([PBPoint]) -> Void

public typealias PBLeaderBoardCompletionBlock = (_ leadearBoard:[PBLeaderBoard], _ playerData:PBLeaderBoard?) -> Void

public typealias PBContentCompletionBlock = ([PBContent]) -> Void

public typealias PBRanksCompletionBlock = ([PBRank]) -> Void

public typealias PBActionReportsCompletionBlock = ([PBActionReport]) -> Void

public typealias PBRuleCompletionBlock = (PBRule) -> Void

public typealias PBRulesCompletionBlock = ([PBRule]) -> Void

public typealias PBAvailableRedeemPlacesCompletionBlock = (_ redeemPlaces:[PBRedeemPlace]) -> Void

public typealias PBReferralCodeCompletionBlock = (_ code:String) -> Void

public typealias PBLinkCompletionBlock = (_ link:String) -> Void

public typealias PBRecentActivitiesCompletionBlock = (_ activities:[PBRecentActivity]) -> Void

public typealias PBActionCountCompletionBlock = (_ actionId:String?, _ count:Int) -> Void

public typealias PBAppStatusCompletionBlock = (_ appStatus:Bool, _ appPeriod:PBAppPeriod?) -> Void

public typealias PBRemainingPointsCompletionBlock = (_ remainingPoints:[PBRemainingPoint]) -> Void

public typealias PBGameSettingCompletionBlock = (_ gameSettings:[PBGameSetting]) -> Void

public typealias PBGameRulesCompletionBlock = (_ gameRules:[PBGameRule]) -> Void

public typealias PBCampaignCompletionBlock = (_ campaign:PBCampaign) -> Void

public typealias PBCampaignsCompletionBlock = (_ campaigns:[PBCampaign]) -> Void

/**
 Represents a response from the server.
 */
open class PBApiResponse:Mappable {
    
    
    /// Response JSON parsed into a dictionary, or nil if no JSON in response
    fileprivate(set) open var parsedJson:AnyObject?
    /// Whether the request was successful or not
    open var success: Bool = false
    /// The raised error, if any
    open var apiError:PBError?
    /// The message returned
    open var message:String = ""
    /// The error code
    open var errorCode:String = "0000"
    
    
    // MARK: - Initialisation
    
    init() {
        
    }
    
    required public init?(map: Map){}
    
    open func mapping(map: Map) {
        
        success <- map["success"]
        message <- map["message"]
        parsedJson <- map["response"]
        errorCode <- map["error_code"]
        
        self.processError()
    }
    
    public convenience init(response:DataResponse<AnyObject>) {
        let jsonResponse = response.result.value as? [String:AnyObject]
        
        if response.result.isFailure {
            self.init(nsError: response.result.error!, json: jsonResponse)
        }
        else if let jsonResponse = jsonResponse {
            self.init()
            Mapper<PBApiResponse>().map(jsonResponse, toObject: self)
        }
        else {
            print("Failed to get a valid JSON from server")
            let nsError = NSError(domain: API_ERROR_DOMAIN, code: -1, userInfo: nil)
            self.init(nsError: nsError, json: nil)
        }
    }
    
    // Private
    
    fileprivate init(nsError: NSError, json: [String:AnyObject]?) {
        self.success = false
        self.message = nsError.localizedDescription
        self.errorCode = String(nsError.code)
        
        self.processError()
    }
    
    fileprivate func processError() {
        guard success == false else { return }
        self.apiError =  PBError(code: errorCode, message: message)
    }
    
}

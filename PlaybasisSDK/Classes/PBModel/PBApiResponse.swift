//
//  ApiResponse.swift
//  Idea
//
//  Created by Médéric Petit on 4/20/2559 BE.
//  Copyright © 2559 playbasis. All rights reserved.
//

import Alamofire
import ObjectMapper

public typealias PBFailureErrorBlock = (error:PBError) -> Void

public typealias PBEmptyCompletionBlock = () -> Void

typealias PBAuthenticationCompletionBlock = (authenticationToken:PBAuthenticationToken) -> Void

public typealias PBPlayerCompletionBlock = (player:PBPlayer) -> Void

public typealias PBPlayerCustomFieldsCompletionBlock = (customFields:[String:String]) -> Void

public typealias PBPlayerAuthCompletionBlock = (playerId:String) -> Void

public typealias PBPlayerBadgesCompletionBlock = ([PBBadge]) -> Void

public typealias PBQuestCompletionBlock = (PBQuest) -> Void

public typealias PBQuestsCompletionBlock = ([PBQuest]) -> Void

public typealias PBGoodsCompletionBlock = ([PBRewardData]) -> Void

public typealias PBRewardsCompletionBlock = ([PBReward]) -> Void

public typealias PBPointsCompletionBlock = ([PBPoint]) -> Void


public typealias PBLeaderBoardCompletionBlock = (leadearBoard:[PBLeaderBoard], playerData:PBLeaderBoard?) -> Void

public typealias PBContentCompletionBlock = ([PBContent]) -> Void

public typealias PBRanksCompletionBlock = ([PBRank]) -> Void

public typealias PBActionReportsCompletionBlock = ([PBActionReport]) -> Void

public typealias PBRuleCompletionBlock = (PBRule) -> Void
public typealias PBRulesCompletionBlock = ([PBRule]) -> Void

/**
 Represents a response from the server.
 */
public class PBApiResponse:Mappable {
    
    
    /// Response JSON parsed into a dictionary, or nil if no JSON in response
    private(set) public var parsedJson:AnyObject?
    /// Whether the request was successful or not
    public var success: Bool = false
    /// The raised error, if any
    public var apiError:PBError?
    /// The message returned
    public var message:String = ""
    /// The error code
    public var errorCode:String = "0000"
    
    
    // MARK: - Initialisation
    
    init() {
        
    }
    
    required public init?(_ map: Map){}
    
    public func mapping(map: Map) {
        
        success <- map["success"]
        message <- map["message"]
        parsedJson <- map["response"]
        errorCode <- map["error_code"]
        
        self.processError()
    }
    
    public convenience init(response:Response<AnyObject, NSError>) {
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
    
    private init(nsError: NSError, json: [String:AnyObject]?) {
        self.success = false
        self.message = nsError.localizedDescription
        self.errorCode = String(nsError.code)
        
        self.processError()
    }
    
    private func processError() {
        guard success == false else { return }
        self.apiError =  PBError(code: errorCode, message: message)
    }
    
}
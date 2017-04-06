//
//  PBPlayer.swift
//  Playbook
//
//  Created by Médéric Petit on 6/14/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import ObjectMapper

open class PBPlayer:PBModel {
    
    open var playerId:String!
    open var email:String?
    open var firstName:String?
    open var lastName:String?
    open var username:String?
    open var profilePictureUrl:String?
    open var profilePicture:UIImage?
    open var phoneNumber:String?
    open var customFields:[String:String]?
    open var goods:[PBReward] = []
    open var badges:[PBBadge] = []
    open var points:[PBPoint] = []
    
    init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBPlayer>().map(apiResponse.parsedJson!["player"], toObject: self)
    }
    
    public override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
  
    override open func mapping(_ map: Map) {
        super.mapping(map)
        uid <- map["cl_player_id"]
        email <- map["email"]
        username <- map["username"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        profilePictureUrl <- map["image"]
        customFields <- map["custom"]
        playerId <- map["cl_player_id"]
        goods <- map["goods"]
        badges <- map["badges"]
        points <- map["points"]
        phoneNumber <- map["phone_number"]
    }

    init(registerForm:PBRegisterForm) {
        super.init()
        self.email = registerForm.email
        self.username = registerForm.username
        self.playerId = registerForm.playerId
        self.profilePictureUrl = registerForm.profilePictureUrl
        self.customFields = registerForm.customFields
    }
    
}

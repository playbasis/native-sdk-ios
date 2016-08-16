//
//  PBPlayer.swift
//  Playbook
//
//  Created by Médéric Petit on 6/14/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import ObjectMapper

class PBPlayer:PBModel {
    
    var playerId:String!
    var email:String?
    var firstName:String?
    var lastName:String?
    var username:String?
    var profilePictureUrl:String?
    var profilePicture:UIImage?
    var phoneNumber:String?
    var customFields:[String:String]?
    var goods:[PBReward] = []
    var badges:[PBBadge] = []
    var points:[PBPoint] = []
    
    init(apiResponse:PBApiResponse) {
        super.init()
        Mapper<PBPlayer>().map(apiResponse.parsedJson!["player"], toObject: self)
    }
    
    override init() {
        super.init()
    }
  
    override func mapping(map: Map) {
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
    
    required init?(_ map: Map) {
        fatalError("init has not been implemented")
    }
    
}

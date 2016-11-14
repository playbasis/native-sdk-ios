//
//  PBPlayer.swift
//  Playbook
//
//  Created by Médéric Petit on 6/14/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import ObjectMapper

public class PBPlayer:PBModel {
    
    public var playerId:String!
    public var email:String?
    public var firstName:String?
    public var lastName:String?
    public var username:String?
    public var profilePictureUrl:String?
    public var profilePicture:UIImage?
    public var phoneNumber:String?
    public var customFields:[String:String]?
    public var goods:[PBReward] = []
    public var badges:[PBBadge] = []
    public var points:[PBPoint] = []
    public var birthDate:String?
    public var gender:Int?
    
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
  
    override public func mapping(map: Map) {
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
        birthDate <- map["birth_date"]
        gender <- map["gender"]
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

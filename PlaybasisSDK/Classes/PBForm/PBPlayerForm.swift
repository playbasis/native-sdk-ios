//
//  PBPlayerFrom.swift
//  Playbook
//
//  Created by Médéric Petit on 8/11/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

enum ApproveStatus:String {
    case Approved = "approved"
    case Rejected = "rejected"
    case Pending = "pending"
}

public class PBPlayerForm: PBForm {

    //Required
    var playerId:String!
    var email:String?
    var username:String?
    
    // Optional
    var password:String?
    var profilePictureUrl:String?
    var profilePicture:UIImage?
    var phoneNumber:String?
    var customFields:[String:String]?
    var approveStatus:ApproveStatus = .Approved
    
    override public func validate()  {
        super.validate()
        guard self.playerId != nil else {
            self.validationError =  PBError(message: PBLocalizedFormatString("validation_player_id_required"), validationErrorType: .PlayerIdRequired)
            return
        }
        if self.email != nil && !self.email!.PBisValidEmail() {
            self.validationError =  PBError(message: PBLocalizedFormatString("validation_email_format"), validationErrorType: .InvalidEmailFormat)
            return
        }
        self.validationError = nil
        return
    }
    
    override public func params() -> [String:String] {
        var params:[String:String] = [:]
        params["id"] = playerId!
        params["approve_status"] = approveStatus.rawValue
        
        if let mEmail = self.email {
            params["email"] = mEmail
        }
        if let mUsername = self.username {
            params["username"] = mUsername
        }
        if let mEmail = self.email {
            params["email"] = mEmail
        }
        if let mPhoneNumber = self.phoneNumber {
            params["phone_number"] = mPhoneNumber
        }
        if let mPassword = self.password {
            params["password"] = mPassword
        }
        if let mProfilePictureUrl = self.profilePictureUrl {
            params["image"] = mProfilePictureUrl
        }
        return params
    }

    
}

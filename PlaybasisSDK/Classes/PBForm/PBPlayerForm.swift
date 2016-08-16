//
//  PBPlayerFrom.swift
//  Playbook
//
//  Created by Médéric Petit on 8/11/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

public enum ApproveStatus:String {
    case Approved = "approved"
    case Rejected = "rejected"
    case Pending = "pending"
}

public class PBPlayerForm: PBForm {

    //Required
    public var playerId:String!
    public var email:String?
    public var username:String?
    
    // Optional
    public var password:String?
    public var profilePictureUrl:String?
    public var profilePicture:UIImage?
    public var phoneNumber:String?
    public var customFields:[String:String]?
    public var approveStatus:ApproveStatus = .Approved
    
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

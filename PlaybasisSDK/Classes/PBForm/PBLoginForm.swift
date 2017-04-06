//
//  PBPlayerForm.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/14/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

//struct ValidationError {
//    public var message:String = ""
//}

public final class PBLoginForm:PBForm {

    public var email:String?
    public var username:String?
    public var password:String?
    
    
    override public func validate()  {
        guard self.email != nil || self.username != nil else {
            
            self.validationError =  PBError(message: PBLocalizedFormatString("validation_email_or_username_required"), validationErrorType: .emailOrUserNameRequired)
            return
        }
        guard !(self.username == nil && self.email != nil && !self.email!.PBisValidEmail()) else {
            self.validationError =  PBError(message: PBLocalizedFormatString("validation_email_format"), validationErrorType: .invalidEmailFormat)
            return
        }
        guard self.password != nil && self.password!.PBisValidPassword()  else {
            self.validationError =  PBError(message: PBLocalizedFormatString("validation_password_invalid"), validationErrorType: .passwordRequired)
            return
        }
        self.validationError = nil
        
        return
    }
    
    override public func params() -> [String:String] {
      //  guard isValid() else { return  nil }
        var params:[String:String] = [:]
        params["password"] = password!
        if let mEmail = self.email {
            params["email"] = mEmail
        }
        if let mUsername = self.username {
            params["username"] = mUsername
        }
        return params
    }
}

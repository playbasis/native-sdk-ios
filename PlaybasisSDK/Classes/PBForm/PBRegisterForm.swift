//
//  PBRegisterForm.swift
//  Playbook
//
//  Created by Nuttapol Thitaweera on 6/15/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

public final class PBRegisterForm: PBPlayerForm {
    
    public var code:String?
    
    override public func validate()  {
        super.validate()
        guard self.playerId != nil else {
            self.validationError =  PBError(message: PBLocalizedFormatString("validation_player_id_required"), validationErrorType: .PlayerIdRequired)
            return
        }
        guard !(self.email != nil && !self.email!.PBisValidEmail()) else {
            self.validationError =  PBError(message: PBLocalizedFormatString("validation_email_format"), validationErrorType: .InvalidEmailFormat)
            return
        }
        guard self.username != nil else {
            self.validationError =  PBError(message: PBLocalizedFormatString("validation_username_required"), validationErrorType: .UsernameRequired)
            return
        }
        self.validationError = nil
        return
    }
    
    override public func params() -> [String:String] {
        var params:[String:String] = super.params()
        if let mCode = self.code {
            params["code"] = mCode
        }
        return params
    }
    
}

//
//  PBExtension.swift
//  Playbook
//
//  Created by Médéric Petit on 6/15/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

func PBLocalizedFormatString(key:String) -> String {
    return NSLocalizedString(key, tableName: "PBLocalizable", bundle: NSBundle.mainBundle(), value: "", comment: "")
}

extension String{

    func PBisValidEmail() -> Bool {
        let emailRegEx = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" + "\\@" +  "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" + "(" +  "\\." +  "[a-zA-Z0-9][a-zA-Z0-9\\-]{1,6}" + ")+"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self)
    }
    
    func PBisValidPassword() -> Bool {
        return self.characters.count >= 6
    }
    
    
    
}
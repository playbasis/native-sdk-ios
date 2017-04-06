//
//  PBForm.swift
//  Playbook
//
//  Created by Médéric Petit on 6/15/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

public protocol Validatable {
    func validate()
    func isValid() -> Bool
}

public protocol Parametrable {
    func params() -> [String:String]
}


open class PBForm:NSObject, Validatable, Parametrable {
    
    open var validationError:PBError?

    open func validate() {
        // Default implementation does nothing
        // Override in subclass
    }
    
    open func isValid() -> Bool {
        self.validate()
        return self.validationError == nil
    }
    
    open func params() -> [String:String] {
        // Default implementation does nothing
        // Override in subclass
        return [:]
    }
}

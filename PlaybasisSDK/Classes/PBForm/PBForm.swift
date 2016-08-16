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


public class PBForm:NSObject, Validatable, Parametrable {
    
    public var validationError:PBError?

    public func validate() {
        // Default implementation does nothing
        // Override in subclass
    }
    
    public func isValid() -> Bool {
        self.validate()
        return self.validationError == nil
    }
    
    public func params() -> [String:String] {
        // Default implementation does nothing
        // Override in subclass
        return [:]
    }
}
//
//  CustomErrorObject.swift
//  Idea
//
//  Created by Médéric Petit on 4/21/2559 BE.
//  Copyright © 2559 playbasis. All rights reserved.
//

import UIKit

public enum PBApiErrorType {
    case networkError
    case networkTimeout
    case invalidToken
    case serverError
    case notFound
    case invalidLoginCredential
    case userNotFound
    case nodeAlreadyExist
    case pinNotMatch
    case localError
    case unauthorized
    case userAlreadyExists
    case emailAlreadyExists
    case canceled
    case invalidCouponCode
}



public enum PBValidationErrorType {
    case invalidEmailFormat
    case passwordRequired
    case passwordNotMatch
    case emailOrUserNameRequired
    case playerIdRequired
    case usernameRequired
}


open class PBError:NSObject {
    
    /// Type of error in the API call, or nil if success
    fileprivate(set) open var remoteError: PBApiErrorType?
    fileprivate(set) open var validationError:PBValidationErrorType?
    
    fileprivate var errorCode:String! = "0000"
    open var message:String = ""
    

    public init(code:String = "0000", message:String) {
        super.init()
        self.message = message
        self.errorCode = code
        self.remoteError = remoteErrorFromCode(code)
    }
    
    public init(message:String,validationErrorType:PBValidationErrorType) {
        super.init()
        self.message = message
        self.validationError = validationErrorType
    }
    
    public convenience init(nsError:NSError) {
        self.init(code: String(nsError.code), message: nsError.localizedDescription)
    }
    
    // MARK: - Private
    
    fileprivate func remoteErrorFromCode(_ code:String) -> PBApiErrorType {
        var error:PBApiErrorType
        switch code {
        // APPLICATION ERROR
        case "0900":
            error = .invalidToken
        case "2406", "0903":
            error = .invalidLoginCredential
        case "0200":
            error = .userNotFound
        case "2402":
            error = .nodeAlreadyExist
        case "2101":
            error = .pinNotMatch
        case "0201", "0215":
            error = .userAlreadyExists
        case "0216":
            error = .emailAlreadyExists
        case "0602":
            error = .invalidCouponCode
        // HTTP ERROR
        case "401":
            error = .unauthorized
        case "404":
            error = .notFound
        // IOS ERROR
        case "-1009":
            error = .networkError
        case "-999":
            error = .canceled
        default:
            error = .localError
        }
        return error
    }

}

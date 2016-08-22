//
//  CustomErrorObject.swift
//  Idea
//
//  Created by Médéric Petit on 4/21/2559 BE.
//  Copyright © 2559 playbasis. All rights reserved.
//

import UIKit

public enum PBApiErrorType {
    case NetworkError
    case NetworkTimeout
    case InvalidToken
    case ServerError
    case NotFound
    case InvalidLoginCredential
    case UserNotFound
    case NodeAlreadyExist
    case PinNotMatch
    case LocalError
    case Unauthorized
    case UserAlreadyExists
    case EmailAlreadyExists
    case Canceled
    case InvalidCouponCode
}



public enum PBValidationErrorType {
    case InvalidEmailFormat
    case PasswordRequired
    case PasswordNotMatch
    case EmailOrUserNameRequired
    case PlayerIdRequired
    case UsernameRequired
}


public class PBError:NSObject {
    
    /// Type of error in the API call, or nil if success
    private(set) public var remoteError: PBApiErrorType?
    private(set) public var validationError:PBValidationErrorType?
    
    private var errorCode:String! = "0000"
    public var message:String = ""
    

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
    
    private func remoteErrorFromCode(code:String) -> PBApiErrorType {
        var error:PBApiErrorType
        switch code {
        // APPLICATION ERROR
        case "0900":
            error = .InvalidToken
        case "2406", "0903":
            error = .InvalidLoginCredential
        case "0200":
            error = .UserNotFound
        case "2402":
            error = .NodeAlreadyExist
        case "2101":
            error = .PinNotMatch
        case "0201", "0215":
            error = .UserAlreadyExists
        case "0216":
            error = .EmailAlreadyExists
        case "0602":
            error = .InvalidCouponCode
        // HTTP ERROR
        case "401":
            error = .Unauthorized
        case "404":
            error = .NotFound
        // IOS ERROR
        case "-1009":
            error = .NetworkError
        case "-999":
            error = .Canceled
        default:
            error = .LocalError
        }
        return error
    }

}
//
//  PbBaseApi.swift
//  Playbook
//
//  Created by Médéric Petit on 6/14/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

open class PBBaseApi: NSObject {
    
    class func encodePath(_ path:String) -> String {
        return path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? ""
    }

}

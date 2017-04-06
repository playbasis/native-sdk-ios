//
//  PBContentApi.swift
//  Playbook
//
//  Created by Orawan Manasombun on 6/29/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

open class PBContentApi: PBBaseApi {
    
    fileprivate class func contentEndPointWithPath(_ path:String) -> String {
        return PBEndPoint.CONTENT_END_POINT + self.encodePath(path)
    }
    
    open class func getContentListWithForm(_ contentForm:PBContentForm, completionBlock:PBContentCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.GET, endPoint: self.contentEndPointWithPath(""), parameters:contentForm.params(), completionBlock: { (response) in
            let contents:[PBContent] = PBContent.pbContentFromApiResponse(response)
            completionBlock(contents)
            }, failureBlock: failureBlock)
    }
    
}

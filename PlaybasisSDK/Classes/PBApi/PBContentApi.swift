//
//  PBContentApi.swift
//  Playbook
//
//  Created by Orawan Manasombun on 6/29/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import UIKit

class PBContentApi: PBBaseApi {
    
    private class func contentEndPointWithPath(path:String) -> String {
        return PBEndPoint.CONTENT_END_POINT + path
    }
    
    class func getContentListWithForm(contentForm:PBContentForm, completionBlock:PBContentCompletionBlock, failureBlock:PBFailureErrorBlock){
        PBRestController.request(.GET, endPoint: self.contentEndPointWithPath(""), parameters:contentForm.params(), completionBlock: { (response) in
            let contents:[PBContent] = PBContent.pbContentFromApiResponse(response)
            completionBlock(contents)
            }, failureBlock: failureBlock)
    }
    
}

//
//  RestController.swift
//  NetworkManager
//
//  Created by Médéric Petit on 6/7/2559 BE.
//  Copyright © 2559 smartsoftasia. All rights reserved.
//

import Alamofire

// Error domain for errors emitted by this class
let API_ERROR_DOMAIN = "RemoteServiceErrorDomain"

protocol PBRestProtocol {
    func request(method:Alamofire.Method, endPoint: String, parameters: [String : AnyObject]?, asynchronous:Bool, encoding: ParameterEncoding, headers: [String: String]?, completionBlock: ((PBApiResponse) -> Void), failureBlock:PBFailureErrorBlock)
    func uploadData(data:NSData, endPoint: String, parameters: [String : AnyObject]?, encoding: ParameterEncoding, headers: [String: String]?, completionBlock: ((PBApiResponse) -> Void), failureBlock:PBFailureErrorBlock)
}

public class PBBaseRestController {
    
    public static let sharedInstance = PBBaseRestController()
    private let manager: Alamofire.Manager = Alamofire.Manager.sharedInstance
    
    private let synchronousQueue:NSOperationQueue = NSOperationQueue()
    
    public init() {
        synchronousQueue.maxConcurrentOperationCount = 1
    }

    
    func createRequest(endPoint:String, method:Alamofire.Method, authenticationData:[String:String]?, encoding:ParameterEncoding, headers: [String: String]? = nil, parameters:[String:AnyObject]?) -> NSURLRequest {
        
        let URLString:URLStringConvertible = PlaybasisSDK.sharedInstance.apiUrl + "/" + endPoint
        
        let mutableRequest = NSMutableURLRequest(URL: NSURL(string: URLString.URLString)!)
        mutableRequest.HTTPMethod = method.rawValue
        
        var params = parameters ?? [String:AnyObject]()
        if authenticationData != nil {
            for (key,value) in authenticationData! {
                params.updateValue(value, forKey:key)
            }
        }
        
        let (request, error) = encoding.encode(mutableRequest, parameters: params)
        if let error = error {
            print("Failed to encode request, error: \(error)")
            assert(false)
        }
        
        if let headers = headers {
            for (field, value) in headers {
                request.setValue(value, forHTTPHeaderField: field)
            }
        }
        return request
    }
    
    func performRequest(request:NSURLRequest, asynchronous:Bool = true, completionBlock: ((PBApiResponse) -> Void), failureBlock:PBFailureErrorBlock) {
        
        if asynchronous {
            self.manager.request(request).responseJSON { (response) in
                self.parseResponse(response, successBlock: completionBlock, failureBlock: failureBlock)
            }
        }
        else {
            let synchronousOperation = PBSynchronousNetworkOperation(request: request, manager: self.manager, networkOperationCompletionHandler: { (response) in
                self.parseResponse(response, successBlock: completionBlock, failureBlock: failureBlock)
            })
            synchronousQueue.addOperation(synchronousOperation)
            
            
        }
    }
    
    func performUpload(request:NSURLRequest, data:NSData, authenticationData:[String:String]?, completionBlock: ((PBApiResponse) -> Void), failureBlock:PBFailureErrorBlock) {
        
        self.manager.upload(request, multipartFormData: { (multipartFormData) in
            if authenticationData != nil {
                for (key,value) in authenticationData! {
                    multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
                }
            }
            multipartFormData.appendBodyPart(data: data, name: "file", fileName: "file.jpg", mimeType: "image/jpeg")
        }) { (multipartFormDataEncodingResult) in
            switch multipartFormDataEncodingResult {
            case .Success(let requestEncoded, _, _):
                print(requestEncoded.debugDescription)
                requestEncoded.responseJSON { (response) in
                    self.parseResponse(response, successBlock: completionBlock, failureBlock: failureBlock)
                }
            case .Failure(let encodingError):
                let errorObject:PBError = PBError(nsError: encodingError as NSError)
                failureBlock(error: errorObject)
            }
        }
    }
    
    private func parseResponse(response:Response<AnyObject, NSError>, successBlock:((PBApiResponse) -> Void), failureBlock:PBFailureErrorBlock) {
       // print("Request completed, URL: \(response.request!.URL), response: \(response), status code = \(response.response?.statusCode)")
        let apiResponse:PBApiResponse = PBApiResponse(response:response)
        if let error = apiResponse.apiError {
            failureBlock(error: error)
        }
        else {
            successBlock(apiResponse)
        }
    }
    
    func cancelAll() {
        if #available(iOS 9.0, *) {
            self.manager.session.getAllTasksWithCompletionHandler { tasks in
                tasks.forEach { $0.cancel() }
            }
        } else {
            // Fallback on earlier versions
            self.manager.session.getTasksWithCompletionHandler({ (dataTasks, uploadTasks, DownloadTasks) in
                dataTasks.forEach { $0.cancel() }
                uploadTasks.forEach { $0.cancel() }
                DownloadTasks.forEach { $0.cancel() }
            })
        }
    }
}
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
    func request(_ method:Alamofire.Method, endPoint: String, parameters: [String : AnyObject]?, asynchronous:Bool, encoding: ParameterEncoding, headers: [String: String]?, completionBlock: ((PBApiResponse) -> Void), failureBlock:@escaping PBFailureErrorBlock)
    func uploadData(_ data:Data, endPoint: String, parameters: [String : AnyObject]?, encoding: ParameterEncoding, headers: [String: String]?, completionBlock: ((PBApiResponse) -> Void), failureBlock:@escaping PBFailureErrorBlock)
}

open class PBBaseRestController {
    
    open static let sharedInstance = PBBaseRestController()
    fileprivate let manager: Alamofire.SessionManager = Alamofire.SessionManager.default
    
    fileprivate let synchronousQueue:OperationQueue = OperationQueue()
    
    public init() {
        synchronousQueue.maxConcurrentOperationCount = 1
    }

    
    func createRequest(_ endPoint:String, method:Alamofire.HTTPMethod, authenticationData:[String:String]?, encoding:ParameterEncoding, headers: [String: String]? = nil, parameters:[String:AnyObject]?) -> URLRequest {
        
        let URLString:URLConvertible = PlaybasisSDK.sharedInstance.apiUrl + "/" + endPoint

        guard let url = try? URL(string: URLString.asURL().absoluteString), let unwrappedUrl = url else {
            print("failed to create a request with url \(URLString)")
            assert(false)
        }

        var mutableRequest = URLRequest(url: unwrappedUrl)
        mutableRequest.httpMethod = method.rawValue
        
        var params = parameters ?? [String:AnyObject]()
        if authenticationData != nil {
            for (key,value) in authenticationData! {
                params.updateValue(value as AnyObject, forKey:key)
            }
        }
        
        do {
            var request = try encoding.encode(mutableRequest as URLRequestConvertible, with: params)
            
            if let headers = headers {
                for (field, value) in headers {
                    request.setValue(value, forHTTPHeaderField: field)
                }
            }
            return request
            
        } catch {
            print("failed to encode request \(error)")
            assert(false)
        }
    }
    
    func performRequest(_ request:URLRequest, asynchronous:Bool = true, completionBlock: @escaping ((PBApiResponse) -> Void), failureBlock:@escaping PBFailureErrorBlock) {
        
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
    
    func performUpload(_ request:URLRequest, data:Data, authenticationData:[String:String]?, completionBlock: @escaping ((PBApiResponse) -> Void), failureBlock:@escaping PBFailureErrorBlock) {
        
        self.manager.upload(multipartFormData: { (multipartFormData) in
            if authenticationData != nil {
                for (key,value ) in authenticationData! {
                    multipartFormData.append(value.data(using: .utf8, allowLossyConversion: false)!, withName: key)
                }
            }
        }, to: request.url!) { (multipartFormDtaEncodingResult) in
            switch multipartFormDtaEncodingResult {
            case .success(let requestEncoded, _, _):
                print(requestEncoded.debugDescription)
                requestEncoded.responseJSON(completionHandler: { (response) in
                    self.parseResponse(response, successBlock: completionBlock, failureBlock: failureBlock)
                })
            case .failure(let encodingError):
                let errorObject:PBError = PBError(nsError: encodingError as NSError)
                failureBlock(errorObject)
            }
        }
    }
    
    fileprivate func parseResponse(_ response:DataResponse<Any>, successBlock:((PBApiResponse) -> Void), failureBlock:@escaping PBFailureErrorBlock) {
       // print("Request completed, URL: \(response.request!.URL), response: \(response), status code = \(response.response?.statusCode)")
        let apiResponse:PBApiResponse = PBApiResponse(response:response)
        if let error = apiResponse.apiError {
            failureBlock(error)
        }
        else {
            successBlock(apiResponse)
        }
    }
    
    func cancelAll() {
        if #available(iOS 9.0, *) {
            self.manager.session.getAllTasks { tasks in
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

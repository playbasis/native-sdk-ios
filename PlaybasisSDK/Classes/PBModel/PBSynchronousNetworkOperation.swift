import Alamofire

class PBSynchronousNetworkOperation : PBConcurrentOperation {
    
    // define properties to hold everything that you'll supply when you instantiate
    // this object and will be used when the request finally starts
    //
    // in this example, I'll keep track of (a) URL; and (b) closure to call when request is done
    
    let request: URLRequest
    let manager:Alamofire.SessionManager
    let networkOperationCompletionHandler:(DataResponse<Any>) -> Void
    
    // we'll also keep track of the resulting request operation in case we need to cancel it later
    
    weak var alamofireRequest: Alamofire.Request?
    
    // define init method that captures all of the properties to be used when issuing the request
    
    init(request:URLRequest, manager:Alamofire.SessionManager, networkOperationCompletionHandler:@escaping (DataResponse<Any>) -> Void) {
        self.request = request
        self.manager = manager
        self.networkOperationCompletionHandler = networkOperationCompletionHandler
        super.init()
    }
    
    // when the operation actually starts, this is the method that will be called
    
    override func main() {
        self.manager.request(request).responseJSON { (response) in
            self.networkOperationCompletionHandler(response)
            self.completeOperation()
        }
    }
    
    // we'll also support canceling the request, in case we need it
    
    override func cancel() {
        alamofireRequest?.cancel()
        super.cancel()
    }
}

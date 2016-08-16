//
//  ConcurrentOperation.swift
//
//  Created by Robert Ryan on 9/20/14.
//  Copyright (c) 2014 Robert Ryan. All rights reserved.
//

import Foundation

/// Concurrent Operation base class
///
/// This class performs all of the necessary KVN of `isFinished` and
/// `isExecuting` for a concurrent `NSOperation` subclass. So, to developer
/// a concurrent NSOperation subclass, you instead subclass this class which:
///
/// - must override `main()` with the tasks that initiate the asynchronous task;
///
/// - must call `completeOperation()` function when the asynchronous task is done;
///
/// - optionally, periodically check `self.cancelled` status, performing any clean-up
///   necessary and then ensuring that `completeOperation()` is called; or
///   override `cancel` method, calling `super.cancel()` and then cleaning-up
///   and ensuring `completeOperation()` is called.

class PBConcurrentOperation : NSOperation {
    
    override var asynchronous: Bool {
        return true
    }
    
    private var _executing: Bool = false
    override var executing: Bool {
        get {
            return _executing
        }
        set {
            if (_executing != newValue) {
                self.willChangeValueForKey("isExecuting")
                _executing = newValue
                self.didChangeValueForKey("isExecuting")
            }
        }
    }
    
    private var _finished: Bool = false;
    override var finished: Bool {
        get {
            return _finished
        }
        set {
            if (_finished != newValue) {
                self.willChangeValueForKey("isFinished")
                _finished = newValue
                self.didChangeValueForKey("isFinished")
            }
        }
    }
    
    /// Complete the operation
    ///
    /// This will result in the appropriate KVN of isFinished and isExecuting
    
    func completeOperation() {
        executing = false
        finished  = true
    }
    
    override func start() {
        if (cancelled) {
            finished = true
            return
        }
        
        executing = true
        
        main()
    }
}
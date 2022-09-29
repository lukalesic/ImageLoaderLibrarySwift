//
//  AsyncOperation.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 29.09.2022..
//

import Foundation


class AsynchronousOperation: Operation {
    enum OperationState: Int {
        case ready
        case executing
        case finished
    }
    
    @Atomic var state: OperationState = .ready {
        willSet {
            willChangeValue(forKey: #keyPath(isExecuting))
            willChangeValue(forKey: #keyPath(isFinished))
        }
        
        didSet {
            didChangeValue(forKey: #keyPath(isFinished))
            didChangeValue(forKey: #keyPath(isExecuting))
        }
    }
    
    override var isReady: Bool        { state == .ready && super.isReady }
    override var isExecuting: Bool    { state == .executing }
    override var isFinished: Bool     { state == .finished }
    override var isAsynchronous: Bool { true }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        state = .executing
        main()
    }
    
    
    override func main() {
        assertionFailure("The `main` method should be overridden in concrete subclasses of this abstract class.")
    }
    
    func finish() {
        state = .finished
    }
}


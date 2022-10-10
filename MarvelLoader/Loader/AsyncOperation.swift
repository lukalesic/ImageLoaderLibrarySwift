//
//  AsyncOperation.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 29.09.2022..
//

import Foundation
import SwiftUI

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

@propertyWrapper
struct Atomic<T> {
    var _wrappedValue: T
    let lock = NSLock()
    
    var wrappedValue: T {
        get { synchronized { _wrappedValue } }
        set { synchronized { _wrappedValue = newValue } }
    }
    
    init(wrappedValue: T) {
        _wrappedValue = wrappedValue
    }
    
    func synchronized<T>(block: () throws -> T) rethrows -> T {
        lock.lock()
        defer { lock.unlock() }
        return try block()
    }
}


//
//  Dispatcher.swift
//  SwiftCoroutine
//
//  Created by Alex Belozierov on 23.12.2019.
//  Copyright © 2019 Alex Belozierov. All rights reserved.
//

import Foundation

extension Coroutine {
    
    public struct Dispatcher {
        
        @usableFromInline let dispatchBlock: DispatchBlock
        
        @inlinable public init(dispatcher: @escaping DispatchBlock) {
            dispatchBlock = dispatcher
        }
        
    }
    
}

extension Coroutine.Dispatcher {
    
    public typealias Dispatcher = Coroutine.Dispatcher
    public typealias Block = Coroutine.Block
    public typealias DispatchBlock = (@escaping Block) -> Void
    
    public static let sync = Dispatcher { $0() }
    public static let main = Dispatcher.dispatchQueue(.main)
    public static let global = Dispatcher.dispatchQueue(.global())
    
}


// MARK: - OperationQueue
extension Coroutine.Dispatcher {

    @inlinable public static func operationQueue(_ queue: OperationQueue) -> Dispatcher {
        Dispatcher(dispatcher: queue.addOperation)
    }

}

// MARK: - RunLoop
extension Coroutine.Dispatcher {

    @inlinable public static func runLoop(_ runLoop: RunLoop) -> Dispatcher {
        Dispatcher(dispatcher: runLoop.perform)
    }

}

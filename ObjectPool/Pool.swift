//
//  Pool.swift
//  ObjectPool
//
//  Created by Ray Foote on 12/15/15.
//  Copyright © 2015 fierlion. All rights reserved.
//

import Foundation

class Pool<T> {
    // the pool of objects is a queue
    private var objectPool = [T]()
    // ensure that no two threads use methods getFrom() and returnTo() simultaneously
    private let arrayQ = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_SERIAL)
    // use semaphore as items.count conditional for getFromPool
    private let semaphore:dispatch_semaphore_t
    
    init(items:[T]) {
        objectPool.reserveCapacity(objectPool.count)
        for item in items {
            objectPool.append(item)
        }
        semaphore = dispatch_semaphore_create(items.count)
    }
    
    func getFromPool() -> T? {
        var result:T?
        if (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER) == 0) {
            dispatch_sync(arrayQ, {() in
                result = self.objectPool.removeAtIndex(0)
            })
        }
        return result
    }
    
    func returnToPool(item:T) {
        dispatch_async(arrayQ, {()
            self.objectPool.append(item)
            dispatch_semaphore_signal(self.semaphore)
        })
    }
}

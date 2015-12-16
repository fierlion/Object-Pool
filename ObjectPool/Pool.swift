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
    
    init(items:[T]) {
        objectPool.reserveCapacity(objectPool.count)
        for item in items {
            objectPool.append(item)
        }
    }
    
    func getFromPool() -> T? {
        var result:T?
        if objectPool.count > 0 {
            result = self.objectPool.removeAtIndex(0)
        }
        return result
    }
    
    func returnToPool(item:T) {
        self.objectPool.append(item)
    }
}

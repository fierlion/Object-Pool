//
//  main.swift
//  ObjectPool
//
//  Created by Ray Foote on 12/15/15.
//  Copyright © 2015 fierlion. All rights reserved.
//

import Foundation

//basic use test
let book1 = Library.checkoutBook("Ray")
let book2 = Library.checkoutBook("Sam")
Library.printReport()

Library.returnBook(book1)
Library.returnBook(book2)
Library.printReport()

//concurrency tests
var queue = dispatch_queue_create("libraryQ", DISPATCH_QUEUE_CONCURRENT)
var group = dispatch_group_create()
for i in 1 ... 20 {
    dispatch_group_async(group, queue, {() in
        var book = Library.checkoutBook("reader#\(i)")
        if (book.reader != nil) {
            NSThread.sleepForTimeInterval(Double(rand() % 2))
            Library.returnBook(book)
        }
    })
}
dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
Library.printReport()


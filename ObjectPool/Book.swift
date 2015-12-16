//
//  Book.swift
//  ObjectPool
//
//  Created by Ray Foote on 12/15/15.
//  Copyright © 2015 fierlion. All rights reserved.
//

import Foundation

class Book {
    let author:String
    let title:String
    let stockNumber:Int
    var reader:String?
    var checkoutCount = 0
    
    init(author:String, title:String, stock:Int) {
        self.author = author
        self.title = title
        self.stockNumber = stock
    }
}

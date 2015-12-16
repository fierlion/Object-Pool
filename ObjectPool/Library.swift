//
//  Library.swift
//  ObjectPool
//
//  Created by Ray Foote on 12/16/15.
//  Copyright © 2015 fierlion. All rights reserved.
//

import Foundation

final class Library {
    private var books:[Book]
    private var pool:Pool<Book>
    
    private init(stockLevel:Int) {
        books = [Book]()
        for count in 1 ... stockLevel {
            books.append(Book(author:"Dickens, Charles", title: "Hard Times", stock: count))
        }
        pool = Pool<Book>(items:books)
    }
    
    private class var singleton:Library {
        struct SingletonWrapper {
            static let singleton = Library(stockLevel: 2)
        }
        return SingletonWrapper.singleton
    }
    
    class func checkoutBook(reader:String) -> Book {
        var book = singleton.pool.getFromPool()
        book?.reader = reader
        book?.checkoutCount++
        return book!
    }
    
    class func returnBook(book:Book) {
        book.reader = nil
        singleton.pool.returnToPool(book)
    }
    
    class func printReport() {
        for book in singleton.books {
            print("...Book#\(book.stockNumber)...")
            print("Checked out \(book.checkoutCount) times")
            if (book.reader != nil) {
                print("Checked out to: \(book.reader)")
            }
            else {
                print("in stock.")
            }
        }
    }
}
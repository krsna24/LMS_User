//
//  Book.swift
//  LMS_User
//
//  Created by Krsna Sharma on 29/09/24.
//

import Foundation

struct Book: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var status: String
    var isbn: String?
    var dueDate: Date? // Optional due date property
    
    static let sampleBooks: [Book] = [Book(title: "Swift Programming", author: "Apple Inc.", status: "Available",dueDate: Date()),Book(title: "The SwiftUI Handbook", author: "John Sundell", status: "Checked Out",dueDate: Date()),Book(title: "iOS Development Essentials", author: "Neil Smyth", status: "Available",dueDate: Date()),Book(title: "Design Patterns in Swift", author: "Chris Eidhof", status: "Checked Out",dueDate: Date())]
    
}

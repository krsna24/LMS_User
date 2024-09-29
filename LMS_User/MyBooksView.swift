//
//  MyBooksView.swift
//  LMS_User
//
//  Created by Krsna Sharma on 29/09/24.
//

import SwiftUI

//struct MyBooksView: View {
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 16) {
//                List {
//                    ForEach(Book.sampleBooks.filter { $0.status != "Available" }, id: \.id) { book in
//                        NavigationLink(destination: BookDetailView(book: book)) {
//                            bookRow(for: book)
//                        }
//                        .padding(.vertical, 4)
//                        .listRowInsets(EdgeInsets()) // Remove default padding from list rows
//                    }
//                }
//                .listStyle(InsetGroupedListStyle())
//                .navigationTitle("My Books")
//                .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button(action: {
//                            // Action for adding a new book or any relevant action
//                        }) {
//                            Image(systemName: "plus")
//                                .font(.title) // Enlarging icon for better touch target
//                        }
//                    }
//                }
//            }
//            .background(Color(.systemGroupedBackground)) // Background color for the view
//        }
//    }
//    
//    // Function to create a row for each book
//    private func bookRow(for book: Book) -> some View {
//        HStack {
//            // Book Title and Due Date
//            VStack(alignment: .leading, spacing: 4) {
//                Text(book.title)
//                    .font(.system(.headline, design: .rounded))
//                    .foregroundColor(.primary)
//                    .lineLimit(1)
//                    .truncationMode(.tail)
//                
//                // Dynamic Due Date
//                Text("Due: \(book.dueDate!, formatter: dateFormatter)")
//                    .font(.system(.subheadline, design: .rounded))
//                    .foregroundColor(.secondary)
//            }
//            .padding(.vertical)
//            
//            Spacer()
//            
//            // Status Badge
//            Text(book.status)
//                .font(.system(size: 12, weight: .semibold, design: .rounded))
//                .padding(5)
//                .background(statusBackgroundColor(for: book.status))
//                .foregroundColor(statusTextColor(for: book.status))
//                .cornerRadius(8)
//        }
//        .padding(12) // Padding for better touch target
//        .background(Color(.white)) // White background for list items
//        .cornerRadius(10)
//        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // Shadow for card effect
//    }
//    
//    // Date formatter for due date
//    private var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .none
//        return formatter
//    }
//    
//    // Background color based on the book status
//    private func statusBackgroundColor(for status: String) -> Color {
//        switch status {
//        case "Checked Out":
//            return Color.red.opacity(0.2)
//        case "Overdue":
//            return Color.orange.opacity(0.2)
//        default:
//            return Color.gray.opacity(0.2)
//        }
//    }
//
//    // Text color based on the book status
//    private func statusTextColor(for status: String) -> Color {
//        switch status {
//        case "Checked Out":
//            return .red
//        case "Overdue":
//            return .orange
//        default:
//            return .gray
//        }
//    }
//}


import SwiftUI

struct MyBooksView: View {
    @State private var books: [Book] = Book.sampleBooks // Replace with your book list
    @State private var showingAddBook = false
    
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Text("My Books")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.leading,8)
                    Spacer()
                    
                    Button(action: {
                        showingAddBook = true
                    }) {
                        Image(systemName: "plus")}.padding(.trailing,8)
                    
                    
                    .sheet(isPresented: $showingAddBook) {
                        AddBookView(books: $books)
                    }
                }
                    List {
                        ForEach(books.filter { $0.status != "Available" }, id: \.id) { book in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    if let dueDate = book.dueDate {
                                        Text("Due: \(dueDateFormatted(dueDate))")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                Spacer()
                                Text(book.status)
                                    .font(.caption)
                                    .padding(5)
                                    .background(book.status == "Checked Out" ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
                                    .cornerRadius(5)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
        
    }

    // Helper function to format the due date
    private func dueDateFormatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}


struct AddBookView: View {
    @Binding var books: [Book] // Binding to the book list
    @Environment(\.dismiss) var dismiss // To dismiss the view after adding a book

    @State private var title = ""
    @State private var author = ""
    @State private var status = "Available"
    @State private var isbn = ""
    @State private var dueDate: Date? = nil // Optional due date

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    Picker("Status", selection: $status) {
                        Text("Available").tag("Available")
                        Text("Checked Out").tag("Checked Out")
                    }
                    TextField("ISBN", text: $isbn)
                    DatePicker("Due Date", selection: Binding($dueDate, replacingNilWith: Date()), displayedComponents: .date)
                }
                
                Button(action: addBook) {
                    Text("Add Book")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Add Book")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func addBook() {
        // Create a new book and append it to the list
        let newBook = Book(title: title, author: author, status: status, isbn: isbn, dueDate: dueDate)
        books.append(newBook)
        
        // Dismiss the view after adding the book
        dismiss()
    }
}

// Helper extension to replace nil with a default value in Binding
extension Binding where Value: Equatable {
    init(_ source: Binding<Value?>, replacingNilWith defaultValue: Value) {
        self.init {
            source.wrappedValue ?? defaultValue
        } set: { newValue in
            source.wrappedValue = newValue == defaultValue ? nil : newValue
        }
    }
}

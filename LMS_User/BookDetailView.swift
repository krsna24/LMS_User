//
//  BookDetailView.swift
//  LMS_User
//
//  Created by Krsna Sharma on 29/09/24.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Title
                Text(book.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .padding(.top, 20)

                // Author
                Text("Author: \(book.author)")
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                // Genre
                Text("Genre: Fiction")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.horizontal)

                // Status
                Text("Status: \(book.status)")
                    .font(.headline)
                    .foregroundColor(book.status == "Available" ? .green : .red)
                    .padding(.horizontal)

                // Action Button
                Button(action: {
                    // Borrow or reserve book logic
                }) {
                    Text(book.status == "Available" ? "Borrow Book" : "Reserve Book")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity) // Full width button
                        .background(book.status == "Available" ? Color.green : Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2) // Added shadow for depth
                }
                .padding(.bottom, 20) // Spacing below the button

                Spacer()
            }
        }
        .padding(.vertical) // Add vertical padding for better spacing at the top and bottom
        .background(Color(.systemBackground))
        .navigationTitle("Book Details") // Set navigation title
        .navigationBarTitleDisplayMode(.inline) // Consistent title display mode
    }
}

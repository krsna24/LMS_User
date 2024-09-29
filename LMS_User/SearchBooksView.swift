//
//  SearchBooksView.swift
//  LMS_User
//
//  Created by Krsna Sharma on 29/09/24.
//

import SwiftUI

struct SearchBooksView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // White Background for Search Bar
                VStack {
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)

                            TextField("Search by title, author, or ISBN", text: $searchText)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        .padding(10)
                        .background(Color(.white))
                        .cornerRadius(12)

                        // Clear Button
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)

                // Book List
                List {
                    ForEach(Book.sampleBooks.filter { $0.title.localizedCaseInsensitiveContains(searchText) || searchText.isEmpty }, id: \.id) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            HStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(book.title)
                                        .font(.system(.headline, design: .rounded))
                                        .foregroundColor(.primary)
                                        .lineLimit(1)
                                        .truncationMode(.tail)

                                    Text("Author: \(book.author)")
                                        .font(.system(.subheadline, design: .rounded))
                                        .foregroundColor(.secondary)
                                }
                                .padding(.vertical)

                                Spacer()

                                // Status Badge
                                Text(book.status)
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                                    .padding(5)
                                    .background(book.status == "Available" ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                                    .foregroundColor(book.status == "Available" ? .green : .red)
                                    .cornerRadius(8)
                            }
                            .padding()
                            .background(Color(.white))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // Softer shadow for a subtle effect
                        }
                        .padding(.vertical, 4)
                        .listRowInsets(EdgeInsets()) // Remove default padding from list rows
                    }
                    .listRowBackground(Color.clear) // Clear background to see white items
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Search Books")
                .navigationBarTitleDisplayMode(.inline)
                .background(Color(.systemGroupedBackground)) // Ensure consistent background for the whole view
            }
        }
    }
}

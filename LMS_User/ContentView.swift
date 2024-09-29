////
////  ContentView.swift
////  LMS_User
////
////  Created by Krsna Sharma on 02/09/24.
////
//
//import SwiftUI
//
//struct LibraryUserDashboardView: View {
//    @State private var selectedTab: UserTab = .home
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            HomeView()
//                .tabItem {
//                    Label("Home", systemImage: "house.fill")
//                }
//                .tag(UserTab.home)
//
//            SearchBooksView()
//                .tabItem {
//                    Label("Search", systemImage: "magnifyingglass")
//                }
//                .tag(UserTab.search)
//
//            MyBooksView()
//                .tabItem {
//                    Label("My Books", systemImage: "books.vertical.fill")
//                }
//                .tag(UserTab.myBooks)
//
//            NotificationsView()
//                .tabItem {
//                    Label("Notifications", systemImage: "bell.fill")
//                }
//                .tag(UserTab.notifications)
//
//            UserAccountView()
//                .tabItem {
//                    Label("Account", systemImage: "person.crop.circle")
//                }
//                .tag(UserTab.account)
//        }
//        .accentColor(.blue) // Change the accent color as needed
//    }
//}
//
//enum UserTab: String, CaseIterable {
//    case home, search, myBooks, notifications, account
//}
//
//struct HomeView: View {
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                Text("Welcome to the Library")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(.primary)
//                    .padding(.horizontal)
//                    .padding(.top, 20)
//
//                Text("Explore new books, manage your account, and stay updated with your library activities.")
//                    .font(.title2)
//                    .foregroundColor(.primary)
//                    .padding(.horizontal)
//
//                // Featured Books Section
//                Text("Featured Books")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .padding(.horizontal)
//
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(Book.sampleBooks.prefix(3)) { book in
//                            VStack {
//                                Text(book.title)
//                                    .font(.headline)
//                                    .padding()
//                                    .background(Color(.systemGray6))
//                                    .cornerRadius(12)
//                                    .shadow(radius: 3)
//                            }
//                            .frame(width: 150)
//                            .padding(.horizontal, 5)
//                        }
//                    }
//                }
//                Spacer()
//            }
//        }
//        .background(Color(.systemBackground))
//    }
//}
//
//struct SearchBooksView: View {
//    @State private var searchText = ""
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Search by title, author, or ISBN", text: $searchText)
//                    .padding()
//                    .background(Color(.secondarySystemBackground))
//                    .cornerRadius(10)
//                    .padding()
//
//                List {
//                    ForEach(Book.sampleBooks.filter { $0.title.contains(searchText) || searchText.isEmpty }, id: \.id) { book in
//                        NavigationLink(destination: BookDetailView(book: book)) {
//                            HStack {
//                                VStack(alignment: .leading) {
//                                    Text(book.title)
//                                        .font(.headline)
//                                        .foregroundColor(.primary)
//                                    Text("Author: \(book.author)")
//                                        .font(.subheadline)
//                                        .foregroundColor(.secondary)
//                                }
//                                Spacer()
//                                Text(book.status)
//                                    .font(.caption)
//                                    .padding(5)
//                                    .background(book.status == "Available" ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
//                                    .cornerRadius(5)
//                            }
//                            .padding(.vertical, 5)
//                        }
//                    }
//                }
//                .listStyle(InsetGroupedListStyle())
//                .navigationTitle("Search Books")
//            }
//        }
//    }
//}
//
//struct BookDetailView: View {
//    var book: Book
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                Text(book.title)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(.primary)
//                    .padding(.horizontal)
//                    .padding(.top, 20)
//
//                Text("Author: \(book.author)")
//                    .font(.title2)
//                    .foregroundColor(.secondary)
//                    .padding(.horizontal)
//
//                Text("Genre: Fiction")
//                    .font(.headline)
//                    .foregroundColor(.primary)
//                    .padding(.horizontal)
//
//                Text("Status: \(book.status)")
//                    .font(.headline)
//                    .foregroundColor(book.status == "Available" ? .green : .red)
//                    .padding(.horizontal)
//
//                Button(action: {
//                    // Borrow or reserve book logic
//                }) {
//                    Text(book.status == "Available" ? "Borrow Book" : "Reserve Book")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(book.status == "Available" ? Color.green : Color.blue)
//                        .cornerRadius(10)
//                        .padding(.horizontal)
//                }
//
//                Spacer()
//            }
//        }
//        .background(Color(.systemBackground))
//    }
//}
//
//struct MyBooksView: View {
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(Book.sampleBooks.filter { $0.status != "Available" }, id: \.id) { book in
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(book.title)
//                                .font(.headline)
//                                .foregroundColor(.primary)
//                            Text("Due: 2024-09-10")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                        }
//                        Spacer()
//                        Text("Overdue")
//                            .font(.caption)
//                            .padding(5)
//                            .background(Color.red.opacity(0.1))
//                            .cornerRadius(5)
//                    }
//                    .padding(.vertical, 5)
//                }
//            }
//            .listStyle(InsetGroupedListStyle())
//            .navigationTitle("My Books")
//        }
//    }
//}
//
//struct NotificationsView: View {
//    var body: some View {
//        NavigationView {
//            List {
//                Text("• Your reserved book 'Swift Programming' is now available for pickup.")
//                Text("• Reminder: 'The SwiftUI Handbook' is due on 2024-09-15.")
//                Text("• 'iOS Development Essentials' is overdue. Please return it as soon as possible.")
//            }
//            .listStyle(InsetGroupedListStyle())
//            .navigationTitle("Notifications")
//        }
//    }
//}
//
//struct UserAccountView: View {
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Personal Information").foregroundColor(.primary)) {
//                    TextField("Name", text: .constant("John Doe"))
//                    TextField("Email", text: .constant("johndoe@example.com"))
//                }
//                
//                Section(header: Text("Account Preferences").foregroundColor(.primary)) {
//                    Toggle("Receive Notifications", isOn: .constant(true))
//                    Toggle("Enable Dark Mode", isOn: .constant(false))
//                }
//            }
//            .navigationTitle("Account")
//        }
//    }
//}
//
//// Sample data models for hard-coded content
//struct Book: Identifiable {
//    var id = UUID()
//    var title: String
//    var author: String
//    var status: String
//    
//    static let sampleBooks: [Book] = [
//        Book(title: "Swift Programming", author: "Apple Inc.", status: "Available"),
//        Book(title: "The SwiftUI Handbook", author: "John Sundell", status: "Checked Out"),
//        Book(title: "iOS Development Essentials", author: "Neil Smyth", status: "Available"),
//        Book(title: "Design Patterns in Swift", author: "Chris Eidhof", status: "Checked Out")
//    ]
//}
//
//struct LibraryUserDashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        LibraryUserDashboardView()
//            .previewDevice("iPhone 13")
//    }
//}




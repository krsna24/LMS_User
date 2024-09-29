//
//  LibraryUserDashboardView.swift
//  LMS_User
//
//  Created by Krsna Sharma on 29/09/24.
//

import SwiftUI

struct LibraryUserDashboardView: View {
    @State private var selectedTab: UserTab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(UserTab.home)
            
            SearchBooksView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(UserTab.search)
            
            MyBooksView()
                .tabItem {
                    Label("My Books", systemImage: "books.vertical.fill")
                }
                .tag(UserTab.myBooks)
            
            NotificationsView()
                .tabItem {
                    Label("Notifications", systemImage: "bell.fill")
                }
                .tag(UserTab.notifications)
            
            
                .accentColor(.blue) // Change the accent color as needed
        }
    }
}

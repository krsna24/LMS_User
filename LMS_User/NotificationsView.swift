//
//  NotificationsView.swift
//  LMS_User
//
//  Created by Krsna Sharma on 29/09/24.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        NavigationView {
            List {
                Text("• Your reserved book 'Swift Programming' is now available for pickup.")
                Text("• Reminder: 'The SwiftUI Handbook' is due on 2024-09-15.")
                Text("• 'iOS Development Essentials' is overdue. Please return it as soon as possible.")
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Notifications")
        }
    }
}

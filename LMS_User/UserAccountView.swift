//
//  UserAccountView.swift
//  LMS_User
//
//  Created by Krsna Sharma on 29/09/24.
//

import SwiftUI

struct UserAccountView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information").foregroundColor(.primary)) {
                    TextField("Name", text: .constant("John Doe"))
                    TextField("Email", text: .constant("johndoe@example.com"))
                }
                
                Section(header: Text("Account Preferences").foregroundColor(.primary)) {
                    Toggle("Receive Notifications", isOn: .constant(true))
                    Toggle("Enable Dark Mode", isOn: .constant(false))
                }
            }
            .navigationTitle("Account")
        }
    }
}

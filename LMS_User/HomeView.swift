//
//  HomeView.swift
//  LMS_User
//
//  Created by Krsna Sharma on 29/09/24.
//


import SwiftUI

import SwiftUI

import SwiftUI

struct HomeView: View {
    @State private var showProfile = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Top Bar with Title and Profile Button
                HStack {
                    Text("Home")
                        .font(.system(size: 34, weight: .bold))
                        .padding(.leading, 16)
                        .foregroundColor(.primary)

                    Spacer()

                    Button(action: {
                        showProfile = true
                    }) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.primary)
                    }
                    .padding(.trailing, 16)
                    .sheet(isPresented: $showProfile) {
                        ProfileView()
                    }
                }
                .padding(.top, 16)
                .background(Color(.systemGray6))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Welcome Message
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Welcome to the Library")
                                .font(.title)
                                .foregroundColor(.primary)
                                .padding(.leading, 16)

                            Text("Explore new books, manage your account, and stay updated with your library activities.")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .padding(.leading, 16)
                                .padding(.trailing, 16)
                        }

                        Divider()
                            .padding(.vertical, 16)

                        // Featured Books Section
                        VStack(alignment: .leading) {
                            Text("Featured Books")
                                .font(.headline)
                                .padding(.leading, 16)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(Book.sampleBooks.prefix(3)) { book in
                                        NavigationLink(destination: BookDetailView(book: book)) {
                                            VStack {
                                                Image(systemName: "book.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 100, height: 150)
                                                    .cornerRadius(8)
                                                    .shadow(radius: 4)

                                                Text(book.title)
                                                    .font(.headline)
                                                    .foregroundColor(.primary)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(2)

                                                Text(book.author)
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                                    .lineLimit(1)
                                            }
                                            .frame(width: 120)
                                            .padding()
                                            .background(Color(.systemBackground))
                                            .cornerRadius(10)
                                            .shadow(radius: 4)
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        }

                        Divider()
                            .padding(.vertical, 16)

                        // Recommendations Section
                        VStack(alignment: .leading) {
                            Text("Recommendations for You")
                                .font(.headline)
                                .padding(.leading, 16)

                            ScrollView {
                                ForEach(Book.sampleBooks.filter { $0.status == "Available" }) { book in
                                    NavigationLink(destination: BookDetailView(book: book)) {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(book.title)
                                                    .font(.headline)
                                                    .foregroundColor(.primary)
                                                    .lineLimit(2)

                                                Text(book.author)
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }

                                            Spacer()

                                            Text(book.status)
                                                .font(.caption)
                                                .padding(5)
                                                .background(book.status == "Available" ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                                                .cornerRadius(5)
                                        }
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(10)
                                        .shadow(radius: 2)
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                        }
                    }
                }

                Spacer()
            }
            .background(Color(.systemBackground))
            .navigationBarHidden(true)
        }
    }
}
import SwiftUI

import SwiftUI

struct ProfileView: View {
    // Store the dark mode preference using AppStorage
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    // User Avatar and Basic Info
                    VStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .padding(.top, 40)
                        
                        Text("Krsna Sharma")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        Text("krsna@example.com")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                    }
                    
                    // Profile Settings Form
                    VStack(spacing: 32) {
                        profileSection(title: "Personal Information") {
                            infoRow(label: "Name", value: "Krsna Sharma")
                            infoRow(label: "Email", value: "krsna@example.com")
                        }
                        
                        profileSection(title: "Account Preferences") {
                            Toggle("Receive Notifications", isOn: .constant(true))
                                .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                            
                            // Dark Mode Toggle
                            Toggle(isOn: $isDarkMode) {
                                Text("Enable Dark Mode")
                            }
                            .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                            .onChange(of: isDarkMode) { _ in
                                // Dynamically switch between dark and light mode
                                if isDarkMode {
                                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                                } else {
                                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                                }
                            }
                        }
                        
                        profileSection(title: "Security") {
                            NavigationLink(destination: Text("Change Password")) {
                                profileActionRow(label: "Change Password")
                            }
                            
                            NavigationLink(destination: Text("Two-Factor Authentication")) {
                                profileActionRow(label: "Two-Factor Authentication")
                            }
                        }
                        
                        profileSection(title: "Support") {
                            NavigationLink(destination: Text("Help & Support")) {
                                profileActionRow(label: "Help & Support")
                            }
                            
                            NavigationLink(destination: Text("Privacy Policy")) {
                                profileActionRow(label: "Privacy Policy")
                            }
                            
                            NavigationLink(destination: Text("Terms of Service")) {
                                profileActionRow(label: "Terms of Service")
                            }
                        }
                    }
                    .padding([.leading, .trailing], 16)
                    .background(Color(.systemBackground))
                }
                .padding(.bottom, 40)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // Helper to create sections with headers
    private func profileSection<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)
            
            VStack(spacing: 12) {
                content()
            }
            .padding(16)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
        }
    }
    
    // Helper to create rows for displaying information
    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .foregroundColor(.primary)
        }
        .font(.system(size: 16))
        .padding(.vertical, 8)
    }
    
    // Helper to create tappable action rows
    private func profileActionRow(label: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 16))
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 12)
        .background(Color.clear)
        .contentShape(Rectangle()) // Ensures the whole row is tappable
    }
}//struct HomeView: View {
//    @State private var showProfile = false
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                // Background color
//                Color(.systemBackground)
//                    .edgesIgnoringSafeArea(.all)
//
//                ScrollView {
//                    VStack(alignment: .leading, spacing: 20) {
//                        // Top Heading and Profile Button
//                        HStack {
//                            Text("Home")
//                                .font(.largeTitle)
//                                .fontWeight(.bold)
//                                .foregroundColor(.primary)
//
//                            Spacer()
//
//                            // Profile Button
//                            Button(action: {
//                                showProfile = true
//                            }) {
//                                Image(systemName: "person.crop.circle")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 40, height: 40)
//                                    .foregroundColor(.primary)
//                            }
//                            .sheet(isPresented: $showProfile) {
//                                ProfileView()
//                            }
//                        }
//                        .padding(.horizontal)
//                        .padding(.top, 20)
//
//                        // Subheading
//                        Text("Welcome to the Library")
//                            .font(.title2)
//                            .foregroundColor(.secondary)
//                            .padding(.horizontal)
//                            .padding(.bottom, 10)
//
//                        // Description Text
//                        Text("Explore new books, manage your account, and stay updated with your library activities.")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                            .padding(.horizontal)
//
//                        Divider()
//                            .padding(.vertical)
//
//                        // Featured Books Section
//                        Text("Featured Books")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                            .padding(.horizontal)
//
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack(spacing: 20) {
//                                ForEach(Book.sampleBooks.prefix(3)) { book in
//                                    NavigationLink(destination: BookDetailView(book: book)) {
//                                        VStack {
//                                            // Book Cover Image Placeholder
//                                            Image(systemName: "book.fill")
//                                                .resizable()
//                                                .scaledToFit()
//                                                .frame(width: 120, height: 180)
//                                                .cornerRadius(15)
//                                                .shadow(radius: 5)
//
//                                            Text(book.title)
//                                                .font(.headline)
//                                                .foregroundColor(.primary)
//                                                .multilineTextAlignment(.center)
//                                                .lineLimit(2)
//                                                .padding(.top, 5)
//
//                                            Text(book.author)
//                                                .font(.subheadline)
//                                                .foregroundColor(.secondary)
//                                                .padding(.bottom, 5)
//                                        }
//                                        .padding()
//                                        .background(Color(.systemBackground))
//                                        .cornerRadius(15)
//                                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
//                                    }
//                                    .frame(width: 160)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//
//                        Divider()
//                            .padding(.vertical)
//
//                        // Recommendations Section
//                        Text("Recommendations for You")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                            .padding(.horizontal)
//
//                        ForEach(Book.sampleBooks.filter { $0.status == "Available" }) { book in
//                            NavigationLink(destination: BookDetailView(book: book)) {
//                                HStack {
//                                    Text(book.title)
//                                        .font(.headline)
//                                        .foregroundColor(.primary)
//                                        .padding()
//                                    Spacer()
//                                    Text("Available")
//                                        .font(.caption)
//                                        .padding(5)
//                                        .background(Color.green.opacity(0.1))
//                                        .cornerRadius(5)
//                                }
//                                .padding(.horizontal)
//                                .background(Color(.systemGray6))
//                                .cornerRadius(10)
//                                .shadow(radius: 2)
//                            }
//                            .padding(.vertical, 5) // Adding vertical padding between recommendations
//                        }
//
//                        Spacer()
//                    }
//                    .padding(.bottom, 20)
//                }
//                .padding(.top, 20) // Padding for the top of the ScrollView
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationTitle("") // Empty to prevent title conflict with custom title
//        }
//    }
//}

//struct ProfileView: View {
//    var body: some View {
//        VStack {
//            // Profile Image
//            Image(systemName: "person.crop.circle.fill")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 100, height: 100)
//                .padding(.top, 20)
//
//            // Name Field
//            TextField("Full Name", text: .constant("Krsna Sharma"))
//                .font(.title2)
//                .padding()
//                .background(Color(.systemGray6))
//                .cornerRadius(10)
//                .padding(.horizontal)
//
//            // Email Field
//            TextField("Email", text: .constant("krsna@example.com"))
//                .font(.title2)
//                .padding()
//                .background(Color(.systemGray6))
//                .cornerRadius(10)
//                .padding(.horizontal)
//
//            // Edit Profile Button
//            Button(action: {
//                // Action to edit profile
//            }) {
//                Text("Edit Profile")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//                    .padding(.horizontal)
//            }
//            .padding(.top, 20)
//
//            Spacer()
//        }
//        .navigationTitle("Profile")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}

struct SettingsView: View {
    var body: some View {
        List {
            Section(header: Text("Account")) {
                NavigationLink(destination: Text("Account Details")) {
                    Text("Account Details")
                }
                NavigationLink(destination: Text("Change Password")) {
                    Text("Change Password")
                }
            }

            Section(header: Text("Preferences")) {
                NavigationLink(destination: Text("Notifications")) {
                    Text("Notifications")
                }
                NavigationLink(destination: Text("Privacy")) {
                    Text("Privacy")
                }
            }

            Section(header: Text("Help")) {
                NavigationLink(destination: Text("Help & Support")) {
                    Text("Help & Support")
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurEffectView)
        NSLayoutConstraint.activate([
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}



import SwiftUI

//struct ProfileView: View {
//    @State private var name: String = "Krsna Sharma"
//    @State private var email: String = "krsna@example.com"
//    @State private var phone: String = "123-456-7890"
//    @State private var address: String = "123 Library St, Booktown, BK 12345"
//    @State private var receiveNotifications: Bool = true
//    @State private var enableDarkMode: Bool = false
//    
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 30) {
//                // Profile Header
//                VStack(spacing: 10) {
//                    Image(systemName: "person.crop.circle.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 120, height: 120)
//                        .foregroundColor(.blue)
//                        .padding(.top, 20)
//
//                    Text(name)
//                        .font(.title)
//                        .fontWeight(.semibold)
//
//                    Text(email)
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//
//                    Text("Avid book reader and library member")
//                        .font(.footnote)
//                        .foregroundColor(.secondary)
//                        .padding(.horizontal)
//                        .multilineTextAlignment(.center)
//                }
//
//                // Personal Information Section
//                VStack(spacing: 15) {
//                    HStack {
//                        Text("Personal Information")
//                            .font(.headline)
//                            .foregroundColor(.primary)
//                        Spacer()
//                    }
//                    .padding(.horizontal)
//
//                    ProfileInputField(title: "Name", text: $name)
//                    ProfileInputField(title: "Email", text: $email)
//                    ProfileInputField(title: "Phone", text: $phone)
//                    ProfileInputField(title: "Address", text: $address)
//                }
//                .background(Color(.systemGray6))
//                .cornerRadius(15)
//                .padding(.horizontal)
//
//                // Account Preferences Section
//                VStack(spacing: 15) {
//                    HStack {
//                        Text("Account Preferences")
//                            .font(.headline)
//                            .foregroundColor(.primary)
//                        Spacer()
//                    }
//                    .padding(.horizontal)
//
//                    Toggle(isOn: $receiveNotifications) {
//                        Text("Receive Notifications")
//                            .font(.body)
//                            .foregroundColor(.primary)
//                    }
//                    .padding(.horizontal)
//
//                    Toggle(isOn: $enableDarkMode) {
//                        Text("Enable Dark Mode")
//                            .font(.body)
//                            .foregroundColor(.primary)
//                    }
//                    .padding(.horizontal)
//                }
//                .background(Color(.systemGray6))
//                .cornerRadius(15)
//                .padding(.horizontal)
//
//                Spacer()
//
//                // Edit Profile and Logout Buttons
//                VStack(spacing: 15) {
//                    Button(action: {
//                        // Edit Profile Action
//                    }) {
//                        Text("Edit Profile")
//                            .font(.headline)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                    .padding(.horizontal)
//
//                    Button(action: {
//                        // Logout Action
//                    }) {
//                        Text("Logout")
//                            .font(.headline)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.red.opacity(0.1))
//                            .foregroundColor(.red)
//                            .cornerRadius(10)
//                    }
//                    .padding(.horizontal)
//                }
//            }
//            .navigationTitle("Profile")
//            .navigationBarTitleDisplayMode(.inline)
//            .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
//        }
//    }
//}

// Custom TextField View for cleaner code and consistent design
struct ProfileInputField: View {
    var title: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.leading)

            TextField(title, text: $text)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .padding(.horizontal)
        }
    }
}

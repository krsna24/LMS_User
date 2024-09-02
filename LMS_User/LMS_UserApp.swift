//
//  LMS_UserApp.swift
//  LMS_User
//
//  Created by Krsna Sharma on 02/09/24.
//

import SwiftUI

@main
struct LMS_UserApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LibraryUserDashboardView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

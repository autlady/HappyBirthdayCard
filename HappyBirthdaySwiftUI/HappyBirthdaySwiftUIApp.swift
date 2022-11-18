//
//  HappyBirthdaySwiftUIApp.swift
//  HappyBirthdaySwiftUI
//
//  Created by  Юлия Григорьева on 15.11.2022.
//

import SwiftUI

@main
struct HappyBirthdaySwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BirthdayCard()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

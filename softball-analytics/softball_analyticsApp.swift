//
//  softball_analyticsApp.swift
//  softball-analytics
//
//  Created by Hank Elsesser on 9/26/25.
//

import SwiftUI
import SwiftData

@main
struct softball_analyticsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Season.self,
            Team.self,
            Player.self,
            Game.self,
            Play.self,
            Runner.self
        ])
        
        // This configuration works for local storage or private CloudKit syncing.
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

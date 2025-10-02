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
            // List all of your @Model classes here
            Season.self,
            Team.self,
            SeasonRoster.self, // Many-to-many bridge for Season <-> Team
            Player.self,
            RosterEntry.self,  // Many-to-many bridge for Player <-> Roster
            Game.self,
            Play.self,
            Runner.self
        ])
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

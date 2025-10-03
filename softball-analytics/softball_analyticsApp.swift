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
        
//        Container identifier: iCloud.softballData
        
        /*
         
         init(String?, schema: Schema?, isStoredInMemoryOnly: Bool, allowsSave: Bool, groupContainer: ModelConfiguration.GroupContainer, cloudKitDatabase: ModelConfiguration.CloudKitDatabase)
         */


//        
//        let database = ModelConfiguration.CloudKitDatabase(containerIdentifier: "iCloud.softballData",
//                                                           database: .private) // or .public / .shared)
////        
        var modelConfiguration = ModelConfiguration(schema: schema,
                                                    isStoredInMemoryOnly: false,
                                                    allowsSave: true,
//                                                    groupContainer: ModelConfiguration.GroupContainer,
                                                    cloudKitDatabase: .private("iCloud.softballData"))
        

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            SeasonView()
        }
        .modelContainer(sharedModelContainer)
    }
}

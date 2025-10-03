//
//  remove_from_db.swift
//  softball-analytics
//
//  Created by Hank Elsesser on 10/3/25.
//

import Foundation
import SwiftData

func deleteAll<T: PersistentModel>(_ type: T.Type, context: ModelContext) {
    do {
        let descriptor = FetchDescriptor<T>()   // concrete type here
        let objects = try context.fetch(descriptor)
        for obj in objects {
            context.delete(obj)
        }
        try context.save()
        print("✅ Deleted all \(type) objects")
    } catch {
        print("❌ Error deleting \(type): \(error)")
    }
}

func deleteAllData(context: ModelContext) {
    deleteAll(Season.self, context: context)
    deleteAll(Team.self, context: context)
    deleteAll(SeasonRoster.self, context: context)
    deleteAll(Player.self, context: context)
    deleteAll(RosterEntry.self, context: context)
    deleteAll(Game.self, context: context)
    deleteAll(Play.self, context: context)
    deleteAll(Runner.self, context: context)
}

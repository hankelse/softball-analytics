//
//  write_to_db.swift
//  softball-analytics
//
//  Created by Hank Elsesser on 10/3/25.
//

import Foundation
import SwiftData

func saveSeason(_ season: Season, context: ModelContext) {
    context.insert(season)
    do {
        try context.save()
        print("✅ Season saved")
    } catch {
        print("❌ Failed to save season: \(error)")
    }
}

func saveGame(_ game: Game, context: ModelContext) {
    context.insert(game)
    do {
        try context.save()
        print("✅ Game saved")
    } catch {
        print("❌ Failed to save game: \(error)")
    }
}

func savePlay(_ play: Play, context: ModelContext) {
    context.insert(play)
    do {
        try context.save()
        print("✅ Play saved")
    } catch {
        print("❌ Failed to save play: \(error)")
    }
}


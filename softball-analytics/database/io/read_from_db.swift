//
//  read_from_db.swift
//  softball-analytics
//
//  Created by Hank Elsesser on 10/3/25.
//

import SwiftData

func fetchAllSeasons(context: ModelContext) -> [Season] {
    do {
        let descriptor = FetchDescriptor<Season>()
        return try context.fetch(descriptor)
    } catch {
        print("❌ Failed to fetch seasons: \(error)")
        return []
    }
}

func fetchAllGames(context: ModelContext) -> [Game] {
    do {
        let descriptor = FetchDescriptor<Game>()
        return try context.fetch(descriptor)
    } catch {
        print("❌ Failed to fetch games: \(error)")
        return []
    }
}

func fetchAllPlays(context: ModelContext) -> [Play] {
    do {
        let descriptor = FetchDescriptor<Play>()
        return try context.fetch(descriptor)
    } catch {
        print("❌ Failed to fetch plays: \(error)")
        return []
    }
}


func debugPrintPlays(context: ModelContext) {
    do {
        let descriptor = FetchDescriptor<Play>()
        let plays = try context.fetch(descriptor)
        print("📊 Found \(plays.count) plays in database")
        for play in plays {
            print("Play \(play.id) - inning: \(play.inning), outs: \(play.outs), balls: \(play.balls), strikes: \(play.strikes)")
        }
    } catch {
        print("❌ Fetch failed: \(error)")
    }
}

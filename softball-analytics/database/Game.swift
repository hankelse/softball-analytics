//
//  Game.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 9/27/25.
//

import SwiftData
import Foundation

@Model
class Game {
    @Attribute(.unique) var id: UUID = UUID()
    var date: Date
    
    var homeTeam: Team?
    var awayTeam: Team?
    
    var homeTeamLineup: [Player]?
    var awayTeamLineup: [Player]?
    
    @Relationship(deleteRule: .cascade, inverse: \Play.game)
    var plays: [Play]?

    // This is the added property that links a Game back to a Season.
    var season: Season?

    var finalHomeScore: Int?
    var finalAwayScore: Int?

    init(date: Date, season: Season?) { // Added season to initializer
        self.date = date
        self.season = season
    }
}

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
    
    var homeTeam: SeasonRoster?
    var awayTeam: SeasonRoster?
    
    var homeTeamLineup: [Player]?
    var awayTeamLineup: [Player]?
    
    @Relationship(deleteRule: .cascade, inverse: \Play.game)
    var plays: [Play]?

    var season: Season?

    var finalHomeScore: Int?
    var finalAwayScore: Int?

    init(date: Date, season: Season?, homeTeam: SeasonRoster?, awayTeam: SeasonRoster?) {
        self.date = date
        self.season = season
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
}

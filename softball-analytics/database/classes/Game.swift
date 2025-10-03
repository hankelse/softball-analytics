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
//    @Attribute(.unique) var id: UUID = UUID()
    var id: UUID = UUID()
    var date: Date = Date()
    
    var homeRoster: SeasonRoster?
    var awayRoster: SeasonRoster?
    
//    @Relationship(inverse:)
    var homeTeamLineup: [Int]?
    var awayTeamLineup: [Int]?
    
    @Relationship(deleteRule: .cascade, inverse: \Play.game)
    var plays: [Play]?

    var season: Season?

    var finalHomeScore: Int?
    var finalAwayScore: Int?

    init(date: Date, season: Season?, homeRoster: SeasonRoster?, awayRoster: SeasonRoster?) {
        self.date = date
        self.season = season!
        self.homeRoster=homeRoster
        self.awayRoster=awayRoster
        
        if self.plays == nil {
            self.plays = []   // initialize lazily
        }
    }
}

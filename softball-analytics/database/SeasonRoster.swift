//
//  SeasonRoster.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 9/28/25.
//

import SwiftData
import Foundation

@Model
class SeasonRoster {
    @Attribute(.unique) var id: UUID = UUID()
    
    // Link to the team this roster is for
    var team: Team?
    
    // Link to the season this roster is for
    var season: Season?
    
    // The roster of players for THIS TEAM in THIS SEASON.
    // We use RosterEntries as a bridge. This is the roster entry for a given player during a given season.
    @Relationship(deleteRule: .cascade, inverse: \Player.seasonRoster)
    var players: [RosterEntry]?
    
    // Season stats
    var wins: Int = 0
    var losses: Int = 0
    
    init(team: Team, season: Season) {
        self.team = team
        self.season = season
    }
}

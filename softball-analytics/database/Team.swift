//
//  Team.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 9/27/25.
//

import SwiftData
import Foundation

@Model
class Team {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \Player.team)
    var players: [Player]?

    // This is the added property that links a Team back to a Season.
    var season: Season?

    init(name: String, season: Season?) { // Added season to initializer
        self.name = name
        self.season = season
    }
}

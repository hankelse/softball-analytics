//
//  Season.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 9/27/25.
//

import SwiftData
import Foundation

@Model
class Season {
//    @Attribute(.unique) var id: UUID = UUID()
    var id: UUID = UUID()
    var name: String?
    var year: Int?
    
    // This connects to all the teams/rosters participating in this season.
    @Relationship(deleteRule: .cascade, inverse: \SeasonRoster.season)
    var participatingRosters: [SeasonRoster]?
    
    @Relationship(deleteRule: .cascade, inverse: \Game.season)
    var games: [Game]?

    init(name: String, year: Int) {
        self.name = name
        self.year = year
    }
}

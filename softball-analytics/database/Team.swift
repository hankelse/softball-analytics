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
//    @Attribute(.unique) var id: UUID = UUID()
    var id: UUID = UUID()
    var name: String?
    
    // Connects to all instances of this team's participation across all seasons.
    @Relationship(inverse: \SeasonRoster.team)
    var seasonRosters: [SeasonRoster]?

    init(name: String) {
        self.name = name
    }
}

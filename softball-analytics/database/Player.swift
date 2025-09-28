//
//  Player.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 9/27/25.
//

import Foundation
import SwiftData

@Model
class Player {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    
    // This allows navigation from a player to their entire career history.
    @Relationship(inverse: \RosterEntry.player)
    var rosterEntries: [RosterEntry]?

    init(name: String) {
        self.name = name
    }
}

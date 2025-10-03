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
//    @Attribute(.unique) var id: UUID = UUID()
    var id: UUID = UUID()
    var name: String = "Unknown player"
    // This allows navigation from a player to their entire career history.
    @Relationship(inverse: \RosterEntry.player)
    var rosterEntries: [RosterEntry]?
    
    @Relationship(inverse: \Play.batter)
    var playsAsBatter: [Play]?
    
    @Relationship(inverse: \Play.pitcher)
    var playsAsPitcher: [Play]?
    
    @Relationship(inverse: \Runner.player)
    var actionsAsRunner: [Runner]?

    init(name: String) {
        self.name = name
    }
}

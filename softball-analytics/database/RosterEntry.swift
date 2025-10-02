//
//  RosterEntry.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 9/28/25.
//

import SwiftData
import Foundation

@Model
class RosterEntry {
//    @Attribute(.unique) var id: UUID = UUID()
    var id: UUID = UUID()
    
    // The link to the permanent Player identity.
    var player: Player?
    
    // The link to the specific SeasonRoster this entry is for.
    var seasonRoster: SeasonRoster?
    
    // --- Season-Specific Attributes ---
    var jerseyNumber: Int?
    var isPitcher: Bool?
    var isActiveOnRoster: Bool?

    init(player: Player, seasonRoster: SeasonRoster, jerseyNumber: Int, isPitcher: Bool = false, isActiveOnRoster: Bool = true) {
        self.player = player
        self.seasonRoster = seasonRoster
        self.jerseyNumber = jerseyNumber
        self.isPitcher = isPitcher
        self.isActiveOnRoster = isActiveOnRoster
    }
}

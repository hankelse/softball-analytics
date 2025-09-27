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
    var number: Int
    var isActive: Bool
    var isPitcher: Bool // Your "Pitcher boolean"

    var team: Team? // The team this player belongs to.

    // NOTE: You do not need to store arrays of plays here.
    // SwiftData's inverse relationships allow you to query for this.
    // For example, you can fetch all Plays where play.batter == thisPlayer.

    init(name: String, number: Int, isActive: Bool = true, isPitcher: Bool = false) {
        self.name = name
        self.number = number
        self.isActive = isActive
        self.isPitcher = isPitcher
    }
}

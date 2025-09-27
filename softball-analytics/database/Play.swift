//
//  Play.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 9/27/25.
//

import Foundation
import SwiftData

// MARK: - Supporting Enums

@Model
class Play {
    @Attribute(.unique) var id: UUID = UUID()
    var timestamp: Date = Date()
    var comment: String?
    
    // GameState attributes
    var inning: Int
    var isTopInning: Bool
    var balls: Int
    var strikes: Int
    var outs: Int
    
    // Participants
    var pitcher: Player?
    var batter: Player?
    
    // Pitch attributes
    var pitchType: PitchType?
    var pitchResult: PitchResult?
    var pitchZoneX: Double?
    var pitchZoneY: Double?
    
    // Hit attributes (if applicable)
    var hitLocationX: Double?
    var hitLocationY: Double?
    
    // Relationship to the game it belongs to
    var game: Game?
    
    // Actions taken by runners as a result of this play.
    @Relationship(deleteRule: .cascade, inverse: \Runner.play)
    var runnerActions: [Runner]?

    init(inning: Int, isTopInning: Bool, balls: Int, strikes: Int, outs: Int) {
        self.inning = inning
        self.isTopInning = isTopInning
        self.balls = balls
        self.strikes = strikes
        self.outs = outs
    }
}

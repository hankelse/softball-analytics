//
//  Play.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 9/27/25.
//

import Foundation
import SwiftData

@Model
class Play {
//    @Attribute(.unique) var id: UUID = UUID()
    var id: UUID = UUID()
    var timestamp: Date = Date()
    var comment: String?
    
    // GameState attributes
    var inning: Int = 1
    var isTopInning: Bool?
    var balls: Int = 0
    var strikes: Int = 0
    var outs: Int = -1
    
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
    var runners: [Runner]?

    init(inning: Int, isTopInning: Bool, balls: Int, strikes: Int, outs: Int) {
        self.inning = inning
        self.isTopInning = isTopInning
        self.balls = balls
        self.strikes = strikes
        self.outs = outs
    }
}

//
//  Runner.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 9/27/25.
//
import Foundation
import SwiftData

@Model
class Runner {
    @Attribute(.unique) var id: UUID = UUID()
    
    // The player who is running.
    var player: Player?
    
    // The play that caused this action. This is the inverse relationship.
    var play: Play?
    
    // Where the runner ended up. Nil if they scored or were put out.
    var base: Base?
    
    // Your boolean flags and out reason.
    var didScore: Bool
    var wasOut: Bool
    var outReason: OutReason?

    init(player: Player, play: Play, base: Base?, didScore: Bool, wasOut: Bool, outReason: OutReason? = nil) {
        self.player = player
        self.play = play
        self.base = base
        self.didScore = didScore
        self.wasOut = wasOut
        self.outReason = outReason
    }
}

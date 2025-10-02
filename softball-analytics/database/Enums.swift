//
//  Enums.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 9/27/25.
//

import Foundation

// Used by RunnerAction to define a player's position on the bases.
enum Base: Int, Codable, CaseIterable {
    case batterBox = 0
    case first = 1
    case second = 2
    case third = 3
    case home = 4
}

// Used by Play to categorize the type of pitch thrown.
enum PitchType: String, Codable, CaseIterable {
    case fastball, curve, dropCurve, screwball, changeup, drop, rise
}

// Used by Play to define the outcome of a pitch.
enum PitchResult: String, Codable, CaseIterable {
    case ball, strikeLooking, strikeSwinging, foul, hit, hitByPitch
}

// Used by RunnerAction to specify why a player was out.
enum OutReason: String, Codable, CaseIterable {
    case forceOut, tagOut, flyOut, groundout, caughtStealing, fielderChoice
}

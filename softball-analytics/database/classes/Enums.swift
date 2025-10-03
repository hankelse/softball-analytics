//
//  Enums.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 9/27/25.
//

import Foundation

// Protocol for enums that can be displayed in a button row
protocol ButtonRowDisplayable: CaseIterable, Hashable {
    var abbreviation: String { get }
}

// Used by RunnerAction to define a player's position on the bases.
enum Base: Int, Codable, CaseIterable {
    case batterBox = 0
    case first = 1
    case second = 2
    case third = 3
    case home = 4
}

// Used by Play to categorize the type of pitch thrown.
enum PitchType: String, Codable, CaseIterable, ButtonRowDisplayable {
    case fastball, curve, dropCurve, screwball, changeup, drop, rise
    
    var abbreviation: String {
        switch self {
        case .fastball:
            return "FB"
        case .curve:
            return "CV"
        case .dropCurve:
            return "DC"
        case .screwball:
            return "SB"
        case .changeup:
            return "CH"
        case .drop:
            return "DP"
        case .rise:
            return "RS"
        }
    }
}

// Used by Play to define the outcome of a pitch.
enum PitchResult: String, Codable, CaseIterable, ButtonRowDisplayable {
    case ball, strikeLooking, strikeSwinging, foul, hit, hitByPitch
    
    var abbreviation: String {
        switch self {
        case .ball:
            return "B"
        case .strikeLooking:
            return "ꓘ"
        case .strikeSwinging:
            return "K"
        case .foul:
            return "F"
        case .hit:
            return "H"
        case .hitByPitch:
            return "HP"
        }
    }
}

// Used by RunnerAction to specify why a player was out.
enum OutReason: String, Codable, CaseIterable {
    case forceOut, tagOut, flyOut, groundout, caughtStealing, fielderChoice
}

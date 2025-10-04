//
//  PlayView.swift
//  softball-analytics
//
//  Created by Hank Elsesser on 9/26/25.
//

import SwiftUI
import SwiftData

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17,
                                  (int >> 4 & 0xF) * 17,
                                  (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16,
                                  int >> 8 & 0xFF,
                                  int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24,
                                  int >> 16 & 0xFF,
                                  int >> 8 & 0xFF,
                                  int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct PlayView: View {
    @Environment(\.modelContext) private var context
    
    // Current game
    @Bindable var game: Game
    // Holds the current play info
    @State var curr_play: Play
    
    
    @State private var batterName: String = ""
    @State private var pitcherName: String = ""
    @State private var teamName: String = ""
    @State private var pitchingType: PitchType?
    @State private var pitchingResult: PitchResult?
    @State private var notes: String = ""
    @State private var showExtraFields1: Bool = false
    @State private var showExtraFields2: Bool = false

    init(game: Game) {
        self.game = game
        if let lastPlay = game.plays?.last {
            self._curr_play = State(initialValue: lastPlay)
        } else {
            let newPlay = Play(inning: 1, isTopInning: true, balls: 0, strikes: 0, outs: 0)
            newPlay.game = game
            game.plays?.append(newPlay)
            self._curr_play = State(initialValue: newPlay)
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                /*
                // HEADER
                Rectangle()
                    .fill(Color(hex: "#002f86"))
                    .frame(height: 60)
                    .overlay(
                        Text("SOFTBALL ANALYTICS")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                 )
                 
                 */

                Spacer()
                
                TopBanner(
                    inning: $curr_play.inning,
                    isTopInning: $curr_play.isTopInning
                )
                
                // MAIN CONTENT AREA
                HStack(alignment: .top, spacing: 2) {
                    // LEFT BOX (Original content)
                    
                    ScrollView {
                        // ===== SECTION 1: Pitch Entry Menu =====
                        VStack {
                            PitchEntryForm(
                                batterName: $batterName,
                                pitcherName: $pitcherName,
                                pitchingType: $pitchingType,
                                pitchingResult: $pitchingResult,
                                onNextPitch: {
                                    saveData()
                                }
                            )
                        }
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 0)
                        )
                        
                        
                        // Divider between main section and collapsible section
                        Divider().padding(.vertical, 10)
                        
                        // ===== SECTION 2: Collapsible Menus =====
                        PriorData(
                            showExtraFields1: $showExtraFields1,
                            showExtraFields2: $showExtraFields2
                        )
                    }
//                        .frame(width: .infinity)
//                        .frame(height: .infinity)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 25)
                        .padding(15)

                    
                    
                    // RIGHT BOX (New, scrolls independently)
                    ScrollView {
                        BaserunnerColumn()
                    }
                    .frame(width: 250, height: 700)
                   
                    
                }
                .padding(5)
                .frame(maxWidth: .infinity, alignment: .center)


                Spacer()
                
                /*
                // FOOTER
                Rectangle()
                    .fill(Color(hex: "#002f86"))
                    .frame(height: 50)
                    .overlay(
                        Text("© 2025 Softball Analytics")
                            .font(.footnote)
                            .foregroundColor(.white)
                    )
                 */
            }
        }
        .onAppear {
            self.batterName = curr_play.batter?.name ?? "Unknown Player"
            self.pitcherName = curr_play.pitcher?.name ?? "Unknown Player"
            self.pitchingType = curr_play.pitchType
            self.pitchingResult = curr_play.pitchResult
            self.notes = curr_play.comment ?? ""

        }
    }
    
    private func getNextPlay(prev_play: Play) -> Play {
        // Start with the state of the previous play
        var next_inning = prev_play.inning
        var next_isTopInning = prev_play.isTopInning ?? true
        var next_balls = prev_play.balls
        var next_strikes = prev_play.strikes
        var next_outs = prev_play.outs

        // Determine the outcome of the last pitch
        switch prev_play.pitchResult {
        case .ball:
            if prev_play.balls == 3 { // A walk occurred
                next_balls = 0
                next_strikes = 0
            } else {
                next_balls += 1
            }
            
        case .strikeLooking, .strikeSwinging:
            if prev_play.strikes == 2 { // A strikeout occurred
                next_outs += 1
                next_balls = 0
                next_strikes = 0
            } else {
                next_strikes += 1
            }
            
        case .foul:
            // A foul only adds a strike if there are fewer than 2 strikes.
            if prev_play.strikes < 2 {
                next_strikes += 1
            }
            // The at-bat continues, ball count is unchanged.
            
        case .hit, .hitByPitch:
            // The at-bat is over. Reset the count.
            next_balls = 0
            next_strikes = 0
            
            // Check for any outs that occurred on the play from runner actions
            let outsOnPlay = prev_play.runners?.filter { $0.wasOut == true }.count ?? 0
            next_outs += outsOnPlay
            
        case .none:
            // If there was no pitch result, assume no change.
            break
        }

        // --- Check for Inning Change ---
        // If the number of outs reaches 3 (or more), the inning is over.
        if next_outs >= 3 {
            next_outs = 0
            next_balls = 0
            next_strikes = 0
            
            if next_isTopInning {
                // If it was the top of the inning, switch to the bottom.
                next_isTopInning = false
            } else {
                // If it was the bottom of the inning, switch to the top of the next inning.
                next_isTopInning = true
                next_inning += 1
            }
        }
        
        // Create the new Play object with the calculated game state.
        let next_play = Play(
            inning: next_inning,
            isTopInning: next_isTopInning,
            balls: next_balls,
            strikes: next_strikes,
            outs: next_outs
        )
        
        return next_play
    }

    private func saveData() {
        // Fill in play details
        curr_play.pitchType = pitchingType
        curr_play.pitchResult = pitchingResult
        curr_play.comment = notes

        // Link play to the game
        curr_play.game = game
        game.plays?.append(curr_play)

        // Persist through helper
        savePlay(curr_play, context: context)

        // Debug through helper
        debugPrintPlays(context: context)

        // Reset
        curr_play = getNextPlay(prev_play : curr_play)
    }
    
}



//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Play.self, configurations: config)
//        
//        let sampleSeason = Season(name: "Sample", year: 2025)
//        let sampleHomeTeam = Team(name: "Sample Home Team")
//        let sampleAwayTeam = Team(name: "Sample Away Team")
//        
//        let sampleHomeRoster = SeasonRoster(team: sampleHomeTeam, season: sampleSeason)
//        let sampleAwayRoster = SeasonRoster(team: sampleAwayTeam, season: sampleSeason)
//        
//        let sampleGame = Game(date: Date(), season: sampleSeason, homeRoster: sampleHomeRoster, awayRoster: sampleAwayRoster)
//        
//        let samplePlay = Play(inning: 4, isTopInning: true, balls: 1, strikes: 2, outs: 1)
//        
//        sampleGame.plays.append(samplePlay)
//        
//        let sampleBatter = Player(name: "Lydia Mirabito")
//        samplePlay.batter = sampleBatter
//        
//        let samplePitcher = Player(name: "Mydia Lirabito")
//        samplePlay.pitcher = samplePitcher
//        
//        return PlayView(game: sampleGame)
//            .modelContainer(container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
//}

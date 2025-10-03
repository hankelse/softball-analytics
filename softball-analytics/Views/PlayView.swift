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
        self._curr_play = State(initialValue: game.plays?.last ?? Play(inning: 1, isTopInning: true, balls: 0, strikes: 0, outs: 0))
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
                        .frame(width: .infinity)
                        .frame(height: .infinity)
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
    
    private func getNextPlay() -> Play {
        let next_play = Play(inning: 1, isTopInning: true, balls: 0, strikes: 0, outs: 0)
        return next_play
    }

    private func saveData() {
        
        print(pitchingType ?? "No pitch type recorded")
        print(pitchingResult ?? "No pitch result recorded")
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

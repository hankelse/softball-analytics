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
    
    // This holds the current play info
    @Bindable var play: Play
    
    @State private var playerName: String = ""
    @State private var teamName: String = ""
    @State private var pitchingType: PitchType?
    @State private var pitchingResult: PitchResult?
    @State private var notes: String = ""
    @State private var showExtraFields1: Bool = false
    @State private var showExtraFields2: Bool = false

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
                    inning: $play.inning,
                    isTopInning: $play.isTopInning
                )
                
                // MAIN CONTENT AREA
                HStack(alignment: .top, spacing: 2) {
                    // LEFT BOX (Original content)
                    ScrollView {
                        // ===== SECTION 1: Pitch Entry Menu =====
                        PitchEntryForm(
                            playerName: $playerName,
                            pitchingType: $pitchingType,
                            pitchingResult: $pitchingResult,
                            onNextPitch: {
                                saveData()
                            }
                        )
                        
                        // Divider between main section and collapsible section
                        Divider().padding(.vertical, 10)
                        
                        // ===== SECTION 2: Collapsible Menus =====
                        PriorData(
                            showExtraFields1: $showExtraFields1,
                            showExtraFields2: $showExtraFields2
                        )
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 700)
                    .background(
                        Rectangle()
                            .fill(Color(.systemGray6))
                    )
                    
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
    }

    private func saveData() {
        guard !teamName.isEmpty else {
            print("Please enter a team name before saving.")
            return
        }

        let newTeam = Team(name: teamName)
        context.insert(newTeam)

        do {
            try context.save()
            print("Saved Team: \(newTeam.name ?? "None")")
            teamName = ""
        } catch {
            print("Error saving team: \(error.localizedDescription)")
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Play.self, configurations: config)
        
        let samplePlay = Play(inning: 4, isTopInning: true, balls: 1, strikes: 2, outs: 1)
        
        let sampleBatter = Player(name: "Lydia Mirabito")
        samplePlay.batter = sampleBatter
        
        return PlayView(play: samplePlay)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

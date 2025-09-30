//
//  ContentView.swift
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

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    @State private var playerName: String = ""
    @State private var teamName: String = ""
    @State private var pitchingType: String = ""
    @State private var pitchingResult: String = ""
    @State private var notes: String = ""
    @State private var showExtraFields1: Bool = false
    @State private var showExtraFields2: Bool = false

    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
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

                Spacer()
                
                Rectangle()
                    .fill(Color(hex: "#002f86"))
                    .frame(width: 900, height: 60)
                    .overlay(
                        HStack {
                            Text("GAME VS. WESLEYAN")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            VStack(alignment: .trailing) {
                                Text("HAMILTON: 2")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                Text("WESLEYAN: 0")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal, 10)
                    )

                // MAIN CONTENT AREA
                HStack(alignment: .top, spacing: 2) {
                    // LEFT BOX (Original content)
                    ScrollView {
                        VStack(alignment: .leading, spacing: 25) {
                            Text("TOP OF 3RD")
                                .font(.title2)
                                .foregroundColor(.black)
                            
                            Text("0 - 0")
                                .font(.subheadline)
                                .foregroundColor(.black)


                            VStack {
                                Spacer()

                                HStack(alignment: .center, spacing: 15) {
                                    // Column 1
                                    VStack(spacing: 30) {
                                        TextField("Batter", text: $playerName)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                        
                                        // Pitching Type with white box background
                                        Picker("Pitching Type", selection: $pitchingType) {
                                            ForEach(PitchType.allCases, id: \.self) { type in
                                                Text(type.rawValue.capitalized)
                                            }
                                        }
                                        .pickerStyle(MenuPickerStyle())
                                        .padding(.horizontal, 85)
                                        .background(Color.white)
                                        .cornerRadius(3)
                                        .frame(maxWidth: .infinity)
                                    }

                                    // Column 2
                                    VStack(spacing: 30) {
                                        TextField("VS.", text: $teamName)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                        
                                        // Pitching Result with white box background
                                        
                                        Picker("Pitching Result", selection: $pitchingResult) {
                                            ForEach(PitchResult.allCases, id: \.self) { result in
                                                Text(result.rawValue.capitalized)
                                            }
                                        }
                                        .pickerStyle(MenuPickerStyle())
                                        .padding(.horizontal, 85)
                                        .background(Color.white)
                                        .cornerRadius(3)
                                        .frame(maxWidth: .infinity)
                                    }

                                    // Column 3: Graphic
                                    VStack {
                                        Image("strikeZone")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 150, height: 150)
                                    }
                                }
                                
                                Spacer()
                            }
                            .frame(maxHeight: .infinity)

                            // COLLAPSIBLE SECTION
                            DisclosureGroup("Last Pitch", isExpanded: $showExtraFields1) {
                                VStack(alignment: .leading, spacing: 10) {
                                    TextField("Batting Average", text: .constant(""))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())

                                    TextField("Home Runs", text: .constant(""))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())

                                    TextField("RBIs", text: .constant(""))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                .padding(.top, 5)
                            }
                            .padding(.top, 5)
                            .foregroundColor(Color(hex: "#002f86"))
                            .font(.headline)

                            // SECOND COLLAPSIBLE SECTION
                            DisclosureGroup("2 Pitches Ago", isExpanded: $showExtraFields2) {
                                VStack(alignment: .leading, spacing: 10) {
                                    TextField("Batting Average", text: .constant(""))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())

                                    TextField("Home Runs", text: .constant(""))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())

                                    TextField("RBIs", text: .constant(""))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                .padding(.top, 5)
                            }
                            .padding(.top, 5)
                            .foregroundColor(Color(hex: "#002f86"))
                            .font(.headline)

                            Button("Save") {
                                saveData()
                            }
                            .buttonStyle(.borderedProminent)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .tint(Color(hex: "#002f86"))
                            .padding(.top, 10)
                        }
                        .padding()
                    }
                    .frame(width: 640, height: 700)
                    .background(
                        Rectangle()
                            .fill(Color(.systemGray6))
                    )
                    

                    // RIGHT BOX (New, scrolls independently)
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(1...4, id: \.self) { index in
                                ZStack {
                                    Rectangle()
                                        .fill(Color(.systemGray6))

                                    Image("field")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(10)
                                }
                                .frame(width: 230, height: 200)
                            }
                        }
                        .padding(.bottom)
                    }
                    .frame(width: 250, height: 700)
                   
                    
                }
                .padding(5)
                .frame(maxWidth: .infinity, alignment: .center)


                Spacer()

                // FOOTER
                Rectangle()
                    .fill(Color(hex: "#002f86"))
                    .frame(height: 50)
                    .overlay(
                        Text("© 2025 Softball Analytics")
                            .font(.footnote)
                            .foregroundColor(.white)
                    )
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
            print("Saved Team: \(newTeam.name)")
            teamName = ""
        } catch {
            print("Error saving team: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}

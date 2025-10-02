//
//  PitchEntry.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 10/2/25.
//

import SwiftUI

struct PitchEntryForm: View {
    // Two-way inhertiance from parent view
    @Binding var playerName: String
    @Binding var teamName: String
    @Binding var pitchingType: PitchType?
    @Binding var pitchingResult: PitchResult?
    
    // This is the action to perform when the button is tapped.
    var onNextPitch: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            VStack(alignment: .leading, spacing: 25) {
                VStack {
                    Spacer()
                    HStack(alignment: .center, spacing: 15) {
                        // ... (Column 1 with Pitching Type buttons)
                        VStack(spacing: 20) {
                            TextField("Batter", text: $playerName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Text("Pitching Type") // ...
                            HStack(spacing: 4) {
                                ForEach(PitchType.allCases, id: \.self) { type in
                                    Button(action: { pitchingType = type.rawValue }) {
                                        // ... button style
                                    }
                                }
                            }
                        }
                        
                        VStack(spacing: 20) {
                            TextField("VS.", text: $teamName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Text("Pitching Result") // ...
                            HStack(spacing: 4) {
                                ForEach(PitchResult.allCases, id: \.self) { type in
                                    Button(action: { pitchingResult = type.rawValue }) {
                                        // ... button style
                                    }
                                }
                            }
                        }

                        VStack {
                            Image("strikeZone")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                        }
                    }
                    Button("NEXT PITCH") {
                        onNextPitch()
                    }
                    Spacer()
                }
                .frame(maxHeight: .infinity)
            }
            .padding()
            .background(Color.white)
        }
    }
}

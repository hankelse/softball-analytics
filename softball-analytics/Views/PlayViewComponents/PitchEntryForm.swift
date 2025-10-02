//
//  PitchEntry.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 10/2/25.
//

import SwiftUI

struct PitchEntryForm: View {
    // Two-way inhertiance from parent view
    @Bindable var play: Play
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
                            TextField("Batter", text: $play.batter.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Text("Pitching Type") // ...
                            ButtonRow(selectedValue: $pitchingType)
                        }

                        VStack(spacing: 20) {
                            TextField("VS.", text: $play.pitcher.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Text("Pitching Result") // ...
                            ButtonRow(selectedValue: $pitchingResult)
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
        
//        VStack(alignment: .leading, spacing:25) {
//            Spacer()
//            HStack(alignment: .center, spacing: 15) {
//                TextField("Batter", text: $play.batter.name)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                TextField("Pitcher", text: $play.pitcher.name)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            }
//        }
    }
        
}

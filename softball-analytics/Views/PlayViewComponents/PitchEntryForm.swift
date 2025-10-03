//
//  PitchEntry.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 10/2/25.
//

import SwiftUI

struct PitchEntryForm: View {
    // Two-way inhertiance from parent view
    @Binding var batterName: String
    @Binding var pitcherName: String
    @Binding var pitchingType: PitchType?
    @Binding var pitchingResult: PitchResult?
    
    // This is the action to perform when the button is tapped.
    var onNextPitch: () -> Void
    
    var body: some View {
        VStack {
            // Pitch entry
            VStack (alignment: .leading, spacing: 25) {
                // Batter & pitcher names
                HStack(alignment: .center, spacing: 25) {
                    // Batter label + name
                    HStack(alignment: .center, spacing: 5) {
                        Text("Batter: ")
                        Text(batterName)
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray)
                            )
                            .foregroundColor(.white)
                    }
                    // Hitter label + name
                    HStack(alignment: .center, spacing: 5) {
                        Text("Pitcher: ")
                        Text(pitcherName)
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray)
                            )
                            .foregroundColor(.white)
                    }
                    
                }
                //Pitch info
                HStack(alignment: .center, spacing: 15) {
                    Spacer()
                    // Pitch type & result
                    VStack (spacing:15) {
                        Text("Pitch Type")
                        ButtonRow(selectedValue: $pitchingType)
                        
                        Text("Pitch Result")
                        ButtonRow(selectedValue: $pitchingResult)
                    }
                    Spacer()
                    Image("strikeZone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    Image("field")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Spacer()
                }
                
                // Next pitch button
                HStack(){
                    Spacer()
                    Button("NEXT PITCH") {
                        onNextPitch()
                    }
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .frame(height: 44)
                }
            }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .padding()
        }
            .background(Color.white)
            .padding()

    }
}

//
//  PriorData.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 10/2/25.
//

import SwiftUI

struct PriorData: View {
    @Binding var showExtraFields1: Bool
    @Binding var showExtraFields2: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
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
            .foregroundColor(Color(hex: "#002f86"))
            .font(.headline)
            
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
            .foregroundColor(Color(hex: "#002f86"))
            .font(.headline)
        }
    }
}


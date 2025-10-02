//
//  PriorData.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 10/2/25.
//

import SwiftUI

struct TopBanner: View {
    @Binding var inning: Int
    @Binding var isTopInning: Bool?
    
    var body: some View {
        Rectangle()
            .fill(Color(hex: "#002f86"))
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .overlay(
                HStack {
                    Text("\(isTopInning! ? "TOP" : "BOT") OF \(inning)")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("0-0")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                }
                    .padding(.horizontal, 10)
            )
            .padding(.top, 70)
    }
}


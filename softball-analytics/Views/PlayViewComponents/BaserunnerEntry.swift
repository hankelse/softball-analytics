//
//  PriorData.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 10/2/25.
//

import SwiftUI

struct BaserunnerEntry: View {
    //@Binding var runner : Runner
    @State private var wasOut: Bool = false
    @State private var outReason: OutReason?
    
    var body: some View {
        VStack {
            Toggle(isOn: $wasOut) {
                Text("Was Out?")
            }
            .padding(.horizontal)
            Image("field")
                .resizable()
                .scaledToFit()
                .padding(10)
            

            if !wasOut {
                Button("Advance Runner") {}
                    .padding(5)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            if wasOut {
                Picker("Out Reason", selection: $outReason) {
                    ForEach(OutReason.allCases, id: \.self) { reason in
                        Text(reason.abbreviation).tag(reason as OutReason?)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            }

        }
        .frame(width: 230, height: 300)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 0)
        )
    }
}


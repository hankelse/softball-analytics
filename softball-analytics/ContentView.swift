//
//  ContentView.swift
//  softball-analytics
//
//  Created by Hank Elsesser on 9/26/25.
//

import SwiftUI
import SwiftData

import SwiftUI

struct ContentView: View {
    @State private var playerName: String = ""
    @State private var teamName: String = ""
    @State private var notes: String = ""

    var body: some View {
        VStack {
            Spacer() // pushes content to vertical center

            VStack(alignment: .leading, spacing: 15) {
                Text("Enter Player Info")
                    .font(.title2)

                TextField("Player Name", text: $playerName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Team Name", text: $teamName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextEditor(text: $notes)
                    .frame(height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )

                Button("Save") {
                    print("Player: \(playerName), Team: \(teamName), Notes: \(notes)")
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .center) // center the button
                .padding(.top, 10)
            }
            .padding()
            .frame(maxWidth: 300) // controls width of the box
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
            )

            Spacer() // pushes content from the bottom
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

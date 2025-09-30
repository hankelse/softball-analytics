//
//  ContentView.swift
//  softball-analytics
//
//  Created by Hank Elsesser on 9/26/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var playerName: String = ""
    @State private var teamName: String = ""
    @State private var notes: String = ""
    @State private var showExtraFields1: Bool = false
    @State private var showExtraFields2: Bool = false

    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                // HEADER
                Rectangle()
                    .fill(Color.blue.opacity(0.9))
                    .frame(height: 60)
                    .overlay(
                        Text("Softball Analytics")
                            .font(.headline)
                            .foregroundColor(.white)
                    )

                Spacer()

                // Main
                VStack(alignment: .leading, spacing: 15) {
                    Text("TOP OF 3RD")
                        .font(.title2)
                        .foregroundColor(.black)

                    HStack(spacing: 15) {
                        TextField("Player Name", text: $playerName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        TextField("Team Name", text: $teamName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    HStack(spacing: 15) {
                        TextField("Player Name", text: $playerName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        TextField("Team Name", text: $teamName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    TextEditor(text: $notes)
                        .frame(height: 200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )

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
                    .foregroundColor(.blue)
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
                    .foregroundColor(.blue)
                    .font(.headline)

                    Button("Save") {
                        print("Player: \(playerName), Team: \(teamName), Notes: \(notes)")
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)
                }
                .padding()
                .frame(maxWidth: 800)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                )
                .padding(.horizontal)

                Spacer()

                // FOOTER
                Rectangle()
                    .fill(Color.blue.opacity(0.9))
                    .frame(height: 50)
                    .overlay(
                        Text("© 2025 Softball Analytics")
                            .font(.footnote)
                            .foregroundColor(.white)
                    )
            }
        }
    }
}

#Preview {
    ContentView()
}

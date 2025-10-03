//
//  GameView.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 10/2/25.
//

import SwiftUI
import SwiftData

struct GameView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State var sampleSeason : Season
    @State var sampleHomeTeam : Team
    @State var sampleAwayTeam : Team
    
    @State var sampleHomeRoster : SeasonRoster
    @State var sampleAwayRoster : SeasonRoster
    
    @State var sampleGame : Game
    
    init() {
            // Phase 1: Initialize all stored properties without referencing self
            let season = Season(name: "Sample", year: 2025)
            let homeTeam = Team(name: "Sample Home Team")
            let awayTeam = Team(name: "Sample Away Team")
            
            let homeRoster = SeasonRoster(team: homeTeam, season: season)
            let awayRoster = SeasonRoster(team: awayTeam, season: season)
        
            let game = Game(date: Date(), season: season, homeRoster: homeRoster, awayRoster: awayRoster)
            
            // Now assign the initialized objects to the properties of self
            self.sampleSeason = season
            self.sampleHomeTeam = homeTeam
            self.sampleAwayTeam = awayTeam
            self.sampleHomeRoster = homeRoster
            self.sampleAwayRoster = awayRoster
            
            // Phase 2 can now safely use self
            self.sampleGame = game
        }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to the Game!")
                    .font(.largeTitle)
                    .padding()

                // This NavigationLink presents the PlayView and passes the game
                NavigationLink(destination: PlayView(game: sampleGame)) {
                    Text("Play Game")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Main Menu")
        }
    }
    
}

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
    
    let season: Season
    
    
    @Query private var games: [Game]
    
    init(season: Season) {
        self.season = season
        let seasonID = season.id   // grab the UUID before building predicate

        self._games = Query(
            filter: #Predicate<Game> { game in
                game.season?.id == seasonID   // ✅ note the optional unwrap
            },
            sort: \.date
        )
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Games for \(season.name) \(String(season.year))")
                    .font(.title)
                    .padding()
                
                if games.isEmpty {
                    Text("No games yet")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(games) { game in
                        NavigationLink {
                            PlayView(game: game)
                        } label: {
                            Text("Game on \(game.date.formatted(date: .abbreviated, time: .shortened))")
                        }
                    }
                }
                
                Spacer()
                
                Button("➕ Add New Game") {
                    addNewGame()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .navigationTitle("Games")
        }
    }
    
    private func addNewGame() {
        let homeTeam = Team(name: "Sample Home Team")
        let awayTeam = Team(name: "Sample Away Team")
        
        let homeRoster = SeasonRoster(team: homeTeam, season: season)
        let awayRoster = SeasonRoster(team: awayTeam, season: season)
        
        let game = Game(date: Date(), season: season,
                        homeRoster: homeRoster, awayRoster: awayRoster)
        
        modelContext.insert(homeTeam)
        modelContext.insert(awayTeam)
        modelContext.insert(homeRoster)
        modelContext.insert(awayRoster)
        modelContext.insert(game)
        
        do {
            try modelContext.save()
            print("✅ New game created")
        } catch {
            print("❌ Save failed: \(error)")
        }
    }
}

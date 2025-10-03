import SwiftUI
import SwiftData

struct DebugView: View {
    @Environment(\.modelContext) private var context
    
    @State private var confirmDelete = false
    @State private var statusMessage = ""
    
    // New: area to display fetch results
    @State private var output: [String] = []
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Debug Menu")
                .font(.largeTitle)
                .padding(.top)
            
            // --- Existing Delete Button ---
            Button(role: .destructive) {
                confirmDelete = true
            } label: {
                Text("Delete ALL Data")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .confirmationDialog("Are you sure you want to delete all data?",
                                isPresented: $confirmDelete) {
                Button("Delete All", role: .destructive) {
                    deleteAllData(context: context)
                    statusMessage = "✅ All data deleted"
                }
                Button("Cancel", role: .cancel) {}
            }
            
            if !statusMessage.isEmpty {
                Text(statusMessage)
                    .foregroundColor(.green)
                    .padding()
            }
            
            Divider().padding(.vertical, 10)
            
            // --- New Output Area ---
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(output, id: \.self) { line in
                        Text(line)
                            .font(.system(.body, design: .monospaced))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .frame(maxHeight: 200)
            .padding()
            .border(Color.gray.opacity(0.3))
            
            // --- New Buttons ---
            Button("Get All Seasons") {
                let seasons = fetchAllSeasons(context: context)
                output = ["📊 Found \(seasons.count) seasons"]
                if seasons.count < 20 {
                    for season in seasons {
                        output.append("Season \(season.displayName())")
                    }
                }
            }
            .buttonStyle(DebugButtonStyle(color: .blue))
            
            Button("Get All Games") {
                let games = fetchAllGames(context: context)
                output = ["📊 Found \(games.count) games"]
                var game_index = 0
                if games.count < 20 {
                    for game in games {
                        output.append("\(game.season!.displayName()) - date: \(game.date)")
                        game_index = game_index + 1
                    }
                }
            }
            .buttonStyle(DebugButtonStyle(color: .green))
            
            Button("Get All Plays") {
                let plays = fetchAllPlays(context: context)
                output = ["📊 Found \(plays.count) plays"]
                var play_index = 0
                if plays.count < 20 {
                    for play in plays {
                        output.append("Play \(play_index) - inning: \(play.inning), outs: \(play.outs), balls: \(play.balls), strikes: \(play.strikes)")
                        play_index = play_index + 1
                    }
                }
            }
            .buttonStyle(DebugButtonStyle(color: .orange))
            
            Spacer()
        }
        .padding()
    }
}

struct DebugButtonStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color.opacity(configuration.isPressed ? 0.6 : 1.0))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

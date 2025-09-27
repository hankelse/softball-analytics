import SwiftData
import Foundation

@Model
class Season {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String // e.g., "2025 Spring League"
    var year: Int
    
    // A Season contains multiple games. If the season is deleted, all its games are also deleted.
    @Relationship(deleteRule: .cascade, inverse: \Game.season)
    var games: [Game]?
    
    // A Season has a set of participating teams.
    @Relationship(deleteRule: .cascade, inverse: \Team.season)
    var teams: [Team]?

    init(name: String, year: Int) {
        self.name = name
        self.year = year
    }
}

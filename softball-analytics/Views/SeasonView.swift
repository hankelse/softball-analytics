//
//  SeasonView.swift
//  softball-analytics
//
//  Created by John (Jack) Kertscher on 10/2/25.
//

import SwiftUI
import SwiftData

struct SeasonView: View {
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Season.year, order: .forward) private var seasons: [Season]
    
    // UI state
    @State private var selectedTerm = "Spring"
    @State private var seasonYear = Calendar.current.component(.year, from: Date())
    
    // Generate a reasonable range of years
    private var yearOptions: [Int] {
        let current = Calendar.current.component(.year, from: Date())
        return Array(current-5...current+5) // 5 years back & forward
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select a Season")
                    .font(.largeTitle)
                    .padding()
                
                if seasons.isEmpty {
                    Text("No seasons yet")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(seasons) { season in
                        NavigationLink(
                            destination: GameView(season: season)
                        ) {
                            Text(season.displayName())
                        }
                    }
                }
                
                Spacer()
                
                // Season input row
                HStack(spacing: 15) {
                    Picker("Season", selection: $selectedTerm) {
                        Text("Spring").tag("Spring")
                        Text("Fall").tag("Fall")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: 150)
                    
                    Picker("Year", selection: $seasonYear) {
                        ForEach(yearOptions, id: \.self) { year in
                            Text("\(String(year))").tag(year)
                        }
                    }
                    .frame(maxWidth: 100)
                    
                    Button("Add Season") {
                        let newSeason = Season(name: selectedTerm, year: seasonYear)
                        context.insert(newSeason)
                        do {
                            try context.save()
                            print("✅ Added season: \(newSeason.name) \(newSeason.year)")
                        } catch {
                            print("❌ Failed to save season: \(error)")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
                
                NavigationLink(destination: DebugView()) {
                    Text("Go to Debug Menu")
                        .font(.headline)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 30)
                
            }
            .navigationTitle("Seasons")
        }
    }
}

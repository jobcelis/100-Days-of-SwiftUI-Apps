//
//  ContentView.swift
//  Moonshot
//
//  Created by Job Celis on 7/13/24.
//

import SwiftUI

struct ContentView: View {
    
    // Load astronauts and missions data from JSON files in the app bundle
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    // Define columns for the grid layout
    let columns = [
        GridItem(.adaptive(minimum: 150)) // Adaptive grid items with a minimum width of 150
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            // Navigate to MissionView for the selected mission
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                // Display mission image
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 145, height: 145)
                                    .padding()
                                
                                VStack {
                                    // Display mission name and launch date
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text(mission.formattedLaunchDate)
                                        .font(.footnote)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.lightBackground)
                                )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}

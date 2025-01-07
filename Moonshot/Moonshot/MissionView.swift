//
//  MissionView.swift
//  Moonshot
//
//  Created by Job Celis on 7/20/24.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
        
    let mission: Mission
    let crew: [CrewMember]

    var body: some View {
        ScrollView {
            VStack {
                // Display mission image
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }

                VStack(alignment: .leading) {
                    // Mission highlights section
                    Text("    Mission Highlights")
                        .font(.system(size: 35, weight: .bold))
                        .padding(.bottom, 5)

                    Text(mission.description)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.bottom, 5)
                        .font(.system(size: 20))
                }
                .padding(.horizontal)
                
                Text("Crew")
                    .font(.title.bold())
                    .padding(.bottom, 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { CrewMember in
                            NavigationLink {
                                // Navigate to AstronautView for the selected crew member
                                AstronautView(astronaut: CrewMember.astronaut)
                            } label: {
                                HStack {
                                    // Display crew member's image and details
                                    Image(CrewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 114, height: 82)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.white, lineWidth: 0.50)
                                        )
                                    
                                    VStack(alignment: .leading) {
                                        Text(CrewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        
                                        Text(CrewMember.role)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        // Map mission crew roles to CrewMember instances using astronaut data
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    // Preview for MissionView with sample data
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}

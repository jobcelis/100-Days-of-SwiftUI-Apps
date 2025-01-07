//
//  AstronautView.swift
//  Moonshot
//
//  Created by Job Celis on 7/22/24.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut

    var body: some View {
        ScrollView {
            VStack {
                // Display astronaut's image
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .padding(0.1)

                // Display astronaut's description
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // Preview for AstronautView with sample astronaut data
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return AstronautView(astronaut: astronauts["armstrong"]!)
        .preferredColorScheme(.dark)
}

//
//  Astronaut.swift
//  Moonshot
//
//  Created by Job Celis on 7/13/24.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String       // Unique identifier for the astronaut
    let name: String     // Name of the astronaut
    let description: String // Description of the astronaut's background 
}

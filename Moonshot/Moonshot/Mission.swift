//
//  Mission.swift
//  Moonshot
//
//  Created by Job Celis on 7/15/24.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    // Computed property to return the mission name
    var displayName: String {
        "Apollo \(id)"
    }
    
    // Computed property to return the mission image name
    var image: String {
        "apollo\(id)"
    }
    
    // Computed property to format the launch date
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}

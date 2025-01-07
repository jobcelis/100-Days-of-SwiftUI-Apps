//
//  Color-Theme.swift
//  Moonshot
//
//  Created by Job Celis on 7/17/24.
//

import SwiftUI

// Extension to add custom colors as static properties
extension ShapeStyle where Self == Color {
    
    // Custom dark background color
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    // Custom light background color
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}

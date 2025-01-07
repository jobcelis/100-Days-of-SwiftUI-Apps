//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Job Celis on 7/14/24.
//

//  This extension of the Bundle class provides a method to decode JSON files from the app bundle into a dictionary of Astronaut objects. It handles various error scenarios, including file not found, data loading issues, and JSON decoding errors, providing detailed error messages for each case.


import Foundation

// Extension to add a decode method to Bundle for JSON files
extension Bundle {
    
    // Method to decode a JSON file into a Codable type
    func decode<T: Codable>(_ file: String) -> T {
        
        // Locate the file in the bundle
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        // Load the data from the file
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        // Create a JSONDecoder to decode the data
        let decoder = JSONDecoder()

        // Configure the decoder to parse dates in the expected format
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        // Attempt to decode the data
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}

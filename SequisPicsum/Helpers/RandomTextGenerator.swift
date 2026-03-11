//
//  RandomTextGenerator.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import Foundation

struct RandomTextGenerator {
    static func generateComment(for imageId: String) -> UserComment {
        let firstNames = loadJSONStringArray(filename: "firstNames")
        let lastNames = loadJSONStringArray(filename: "lastNames")
        let nouns = loadJSONStringArray(filename: "nouns")
        let verbs = loadJSONStringArray(filename: "verbs")

        let firstName = firstNames.randomElement() ?? ""
        let lastName = lastNames.randomElement() ?? ""
        let authorFullName = "\(firstName) \(lastName)"

        let initial1 = firstName.first.map { String($0) } ?? ""
        let initial2 = lastName.first.map { String($0) } ?? ""
        let authorInitial = "\(initial1)\(initial2)".uppercased()
        
        let sentenceLength = Int.random(in: 5...10)
        var textParts: [String] = []

        for _ in 0..<sentenceLength {
            let noun = nouns.randomElement() ?? "nouns"
            let verb = verbs.randomElement() ?? "verbs"
            textParts.append("\(noun) \(verb)")
        }

        let text = textParts.joined(separator: " ")

        return UserComment(
            id: UUID(),
            imageId: imageId,
            authorInitial: authorInitial,
            authorFullName: authorFullName,
            text: text,
            createdAt: Date()
        )
    }
    
    private static func loadJSONStringArray(filename: String) -> [String] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let array = try? JSONDecoder().decode([String].self, from: data)
        else {
            print("failed to load or decode \(filename).json")
            return []
        }
        return array
    }
}

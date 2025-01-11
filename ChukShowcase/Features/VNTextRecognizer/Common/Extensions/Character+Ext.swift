//
//  Character+Ext.swift
//  ChukShowcase
//
//  Created by Eco Dev S-SSD  on 11/01/2025.
//

import Foundation

extension Character {
    // Given a list of allowed characters, try to convert self to those in list
    // if not already in it. This handles some common misclassifications for
    // characters that are visually similar and can only be correctly recognized
    // with more context and/or domain knowledge. Some examples (should be read
    // in Menlo or some other font that has different symbols for all characters):
    // 1 and l are the same character in Times New Roman
    // I and l are the same character in Helvetica
    // 0 and O are extremely similar in many fonts
    // oO, wW, cC, sS, pP and others only differ by size in many fonts
    func getSimilarCharacterIfNotIn(allowedChars: String) -> Character {
        let conversionTable = [
            "s": "S",
            "S": "5",
            "5": "S",
            "o": "O",
            "Q": "O",
            "O": "0",
            "0": "O",
            "l": "1",
            "I": "1",
            "1": "l",
            "B": "8",
            "8": "B",
            "6": "b",
            "b": "6",
            "i": "f",
            "f": "i",
            "g": "8",
            "t": "c",
            "c": "t"
        ]
        // Allow a maximum of two substitutions to handle 's' -> 'S' -> '5'.
        let maxSubstitutions = 2
        var current = String(self)
        var counter = 0
        while !allowedChars.contains(current) && counter < maxSubstitutions {
            if let altChar = conversionTable[current] {
                current = altChar
                counter += 1
            } else {
                // Doesn't match anything in our table. Give up.
                break
            }
        }
        
        return current.first!
    }
}

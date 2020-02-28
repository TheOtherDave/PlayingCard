//
//  Suite.swift
//  
//
//  Created by David Sweeris on 2/24/20.
//

import Foundation
import MaybeExpressibleByLiteral

public enum Suite : String, RawRepresentable, Hashable, CaseIterable, CustomStringConvertible, Codable {
    case spades   = "♠️"
    case diamonds = "♦️"
    case clubs    = "♣️"
    case hearts   = "♥️"
    
    public var description: String {
        self.rawValue
    }
    public var placeholderDescription: String {
        switch self {
        case .spades: return "♤"
        case .diamonds: return "♢"
        case .hearts: return "♡"
        case .clubs: return "♧"
        }
    }
}

extension Suite {
    static let spellings = [
        Suite.spades:  [Suite.spades.rawValue,  "S", "s"],
        Suite.diamonds:[Suite.diamonds.rawValue,"D", "d"],
        Suite.clubs:   [Suite.clubs.rawValue,   "C", "c"],
        Suite.hearts:  [Suite.hearts.rawValue,  "H", "h"],
        ]
}

extension Suite : MaybeExpressibleByStringLiteral {
    public static func tryToExpressWithStringLiteral(stringLiteral value: StringLiteralType) -> Suite? {
        guard value.count == 1 else {
            print("Error: The initialization string for a `Suite` must have exactly one character; \"\(value)\" contains \(value.count) characters")
            return nil
        }
        
        // I tried to think of a clever way to do this with a single guard statement or something, but I was spending too much time on it and am just this instead because it works
        for (suite, spelling) in Suite.spellings {
            if spelling.firstIndex(of: value) != nil {
                return suite
            }
        }
        print("Error: \"\(value)\" is not a valid `Suite` string value")
        return nil
    }
}

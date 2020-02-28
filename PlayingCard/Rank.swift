//
//  Rank.swift
//  
//
//  Created by David Sweeris on 2/24/20.
//

import Foundation
import MaybeExpressibleByLiteral

public enum Rank : Int, RawRepresentable, Hashable, CaseIterable, Codable {
    case ace = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
}

extension Rank : Comparable {
    public static func < (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension Rank : CustomStringConvertible {
    public var description: String {
        let d: String
        switch self {
        case .ace:  d = "A"
        case .ten:  d = "T"
        case .jack: d = "J"
        case .queen:d = "Q"
        case .king: d = "K"
        case _:     d = "\(rawValue)"
        }
        return d
    }
}


extension Rank : MaybeExpressibleByStringLiteral {
    public static func tryToExpressWithStringLiteral(stringLiteral value: Self.StringLiteralType) -> Rank? {
        guard value.count == 1 else {
            print("Error: The initialization string for a `Rank` must have exactly one character; \"\(value)\" contains \(value.count) characters")
            return nil
        }
        guard let index =
            (Rank.allCases.map { $0.description }).firstIndex(of: value) ??
            // Do a case-insensitive search
            (Rank.allCases.map { $0.description.lowercased() }).firstIndex(of: value)
            else {
            print("Error: \"\(value)\" is not a valid `Rank` string value")
            return nil
        }

        return Rank.allCases[index]
    }
}

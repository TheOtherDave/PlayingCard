//
//  PlayingCard.swift
//
//
//  Created by David Sweeris on 2/24/20.
//

import MaybeExpressibleByLiteral

public final class PlayingCard : Codable, CustomStringConvertible, Hashable {
    public static func == (lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        lhs.rank == rhs.rank && lhs.suite == rhs.suite
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rank)
        hasher.combine(suite)
    }
    public var rank: Rank
    public var suite: Suite
    
    public var isFaceUp: Bool = false
    
    public var description: String {
        "\(rank)\(suite)"
    }
    public init(rank: Rank, suite: Suite) {
        self.rank = rank
        self.suite = suite
    }
}

extension PlayingCard : MaybeExpressibleByStringLiteral {
   public static func tryToExpressWithStringLiteral(stringLiteral value: String) -> PlayingCard? {
       let strs = Array(value)
       guard strs.count == 2 else {
           print("Error: The initialization string for a `CardData` must have exactly two characters; \"\(value)\" contains \(strs.count) characters")
           return nil
       }
       guard let face = Rank.tryToExpressWithStringLiteral(stringLiteral: "\(strs[0])") else {
           print("Error: Could not create a Face from \(strs[0])")
           return nil
       }
       guard let suite = Suite.tryToExpressWithStringLiteral(stringLiteral: "\(strs[1])") else {
           print("Error: Could not create a Suite from \(strs[1])")
           return nil
       }
       return PlayingCard(rank: face, suite: suite)
    }
}


//
//  LootItem.swift
//  Exercices_SwiftUI
//
//  Created by Maxandre Neveux on 10/01/2024.
//

import SwiftUI

struct LootItem: Identifiable {
    var id: UUID = UUID()
    var quantity: Int = 1
    var name: String
    var type: ItemType
    var rarity: Rarity
    var attackStrength: Int?
    var game: Game
}

enum ItemType: String, CaseIterable {
    case magic = "⭐️"
    case fire = "🔥"
    case ice = "❄️"
    case wind = "💨"
    case poison = "☠️"
    case thunder = "⚡️"
    case dagger = "🗡️"
    case shield = "🛡️"
    case bow = "🏹"
    case ring = "💍"
    case unknown = "🎲"
}

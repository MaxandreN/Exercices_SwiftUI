//
//  AddItemView.swift
//  Exercices_SwiftUI
//
//  Created by Maxandre Neveux on 10/01/2024.
//

import SwiftUI

enum Rarity: CaseIterable {
    case common, uncommon, rare, epic, legendary, unique
}

extension Rarity {
    var color: Color {
        switch self {
        case .common:
            return .gray
        case .uncommon:
            return .green
        case .rare:
            return .blue
        case .epic:
            return .purple
        case .legendary:
            return .orange
        case .unique:
            return .red
        }
    }
}

struct AddItemView: View {
    @EnvironmentObject var inventory: Inventory
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    @State var rarity: Rarity = .common
    @State var game: Game = .emptyGame
    @State var quantity: Int = 1
    @State var type: ItemType = .unknown
    @State var attackStrength: Int = 0
    @State var attack: Bool = false
    
    var sendReadReceipts: Bool {
        return attackStrength == 1
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Nom de l'objet", text: $name)
                Picker("Rareté", selection: $rarity) {
                    ForEach(Rarity.allCases, id: \.self) { rarity in
                        Text(String(describing: rarity).capitalized)
                    }
                }
            }
            
            Section {
                Picker("Jeu", selection: $game) {
                    Text("Non spécifié")
                    ForEach(availableGames, id: \.self) { game in
                        Text(String(describing: game.name).capitalized)
                    }
                }
                Stepper(
                    value: $quantity,
                    in: 1...100,
                    step: 1
                ) {
                    Text("Quantité: \(quantity)")
                }
            }
            
            Section {
                HStack {
                    Text("Type")
                    Spacer()
                    Text(type.rawValue)
                }
                Picker("Type", selection: $type) {
                    ForEach(ItemType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }.pickerStyle(.palette)
            }
            
            Section {
               
                Toggle("Item d'attaque ?", isOn: Binding<Bool>(
                    get: { self.sendReadReceipts },
                    set: { self.attackStrength = $0 ? 1 : 0 }
                ))
            }
           
            Button(action: {
                inventory.addItem(item: LootItem(quantity: quantity, name: name, type: type, rarity: rarity, attackStrength: attackStrength, game: game))
                dismiss()
            }, label: {
                HStack{
                    Text("Ajouter")
                }
            })
        }
    }
}

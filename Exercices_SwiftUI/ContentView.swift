//
//  ContentView.swift
//  Exercices_SwiftUI
//
//  Created by Maxandre Neveux on 10/01/2024.
//

import SwiftUI


class Inventory: ObservableObject {
    @Published var loot: [LootItem] = [
        LootItem(quantity: 3, name: "Sword of Flames", type: .fire, rarity: .epic, attackStrength: 50, game: availableGames[0]),
        LootItem(quantity: 1, name: "Ice Bow", type: .ice, rarity: .rare, attackStrength: 40, game: availableGames[1]),
        LootItem(quantity: 2, name: "Thunder Dagger", type: .thunder, rarity: .legendary, attackStrength: 60, game: availableGames[2]),
        LootItem(quantity: 1, name: "Wind Shield", type: .wind, rarity: .uncommon, attackStrength: nil, game: availableGames[3]),
        LootItem(quantity: 5, name: "Poison Ring", type: .poison, rarity: .common, attackStrength: nil, game: availableGames[4]),
        LootItem(quantity: 1, name: "Mystery Item", type: .unknown, rarity: .unique, attackStrength: nil, game: availableGames[0]),
        LootItem(quantity: 2, name: "Magic Bow", type: .magic, rarity: .epic, attackStrength: 55, game: availableGames[1]),
        LootItem(quantity: 1, name: "Legendary Shield", type: .shield, rarity: .legendary, attackStrength: nil, game: availableGames[2]),
        LootItem(quantity: 3, name: "Epic Dagger", type: .dagger, rarity: .epic, attackStrength: 48, game: availableGames[3]),
        LootItem(quantity: 1, name: "Rare Poison Ring", type: .poison, rarity: .rare, attackStrength: nil, game: availableGames[4])
    ]

    func addItem(item: LootItem) {
        loot.append(item)
    }
}

struct ContentView: View {
    @StateObject var inventory = Inventory()
    @State var addItemSheetPresented = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(inventory.loot) { item in
                    HStack{
                        VStack{
                            HStack{
                                Circle()
                                    .fill(item.rarity.color)
                                    .frame(width: 10)
                                Text(item.name)
                            }
                            Text("Quantityé : " + String(item.quantity))
                        }
                        Spacer()
                        Text(item.type.rawValue)
                    }
                }
            }
            .sheet(isPresented: $addItemSheetPresented, content: {
                    AddItemView()
                        .environmentObject(inventory)
                })
            .navigationBarTitle("Inventory")
                .toolbar(content: {
                    ToolbarItem(placement: ToolbarItemPlacement.automatic) {
                        Button(action: {
                            addItemSheetPresented.toggle()
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                        })
                    }
                })
        }
    }
}

#Preview {
    ContentView()
}

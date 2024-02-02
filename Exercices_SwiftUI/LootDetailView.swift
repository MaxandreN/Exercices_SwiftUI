//
//  LootDetailView.swift
//  Exercices_SwiftUI
//
//  Created by Maxandre Neveux on 01/02/2024.
//

import SwiftUI

extension Animation {
    static func bounceOut(duration: Double = 0.4) -> Animation {
        Animation.timingCurve(0.68, -0.55, 0.27, 1.55, duration: duration)
    }
}

struct LootDetailView: View {
    var lootItem: LootItem
    
    @State private var rotationAngleX: Double = 0
    @State private var rotationAngleY: Double = 0
    @State private var shadowRadius: CGFloat = 0
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(lootItem.rarity.color)
                .frame(width: 120, height: 120)
                .overlay(
                    Text(lootItem.type.rawValue)
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                )
                .rotation3DEffect(
                    .degrees(rotationAngleX),
                    axis: (x: 1, y: 0, z: 0)
                )
                .rotation3DEffect(
                    .degrees(rotationAngleY),
                    axis: (x: 0, y: 1, z: 0)
                )
                .shadow(color: lootItem.rarity.color, radius: shadowRadius)
                .onAppear {
                    withAnimation(.spring()) {
                        rotationAngleX = 360
                        rotationAngleY = 180
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.interpolatingSpring(stiffness: 0.5, damping: 0.5)) {
                            shadowRadius = 30.0
                        }
                    }
                }
            
            
            Text(lootItem.name)
                .bold()
                .font(.system(size: 30)) // Ajuster la taille du titre
                .foregroundColor(lootItem.rarity.color)
                .padding(.top, 16)
            
            if lootItem.rarity == .unique {
                RoundedRectangle(cornerRadius: 10)
                    .fill(lootItem.rarity.color)
                    .frame(height: 40)
                    .overlay(
                        Text("Item unique 🏆")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    )
                    .padding(.top, 8)
            }
            
            List{
                Section(header: Text("Informations").font(.headline)) {
                    InformationRow(title: "Nom du jeu", value: lootItem.game.name, imageName: lootItem.game.coverName)
                    InformationRow(title: "In-game :", value: lootItem.name)
                    
                    if let attackStrength = lootItem.attackStrength {
                        InformationRow(title: "Puissance (ATQ)", value: "\(attackStrength)")
                    }
                    
                    InformationRow(title: "Possédé(s)", value: "\(lootItem.quantity)")
                    InformationRow(title: "Rareté", value: lootItem.rarity.rawValue)
                }
            }
            Spacer()
        }
    }
}

struct InformationRow: View {
    var title: String
    var value: String
    var imageName: String?
    
    var body: some View {
        HStack {
            if let imageName = imageName, let image = UIImage(named: imageName) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 58, height: 58)
                    .cornerRadius(4)
                    .padding(.trailing, 8)
            } else if let imageName = imageName {
                AlternativeImageView()
            } else {
                Text(title)
                    .font(.body)
                    .foregroundColor(.secondary)
                Spacer()
            }
            Text(value)
        }
        .padding(.vertical, 4)
    }
}



struct AlternativeImageView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 58)
            
            Image(systemName: "rectangle.slash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black.opacity(0.4))
                .frame(width: 24, height: 24)
                .padding(16) // Ajuster le padding pour correspondre à la mise en page souhaitée
        }
    }
}



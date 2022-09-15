//
//  Dragon.swift
//  HardJSONDecodingAssignment
//
//  Created by Denisse Verdiales on 12/07/22.
//

import Foundation


struct Dragon{
    let damageRelations: DamageRelations
    let gameIndices: [GameIndices]
    let generation: NameLink
    let id: Int
    let moveDamageClass: NameLink
    let moves: [NameLink]
    let name: String
    let pokemon: [Pokemon]
}

struct DamageRelations{
    let doubleDamageFrom:[NameLink]
    let doubleDamageTo: [NameLink]
    let halfDamageFrom: [NameLink]
    let halfDamageTo: [NameLink]
    let noDamageFrom: [NameLink]
    let noDamageTo: [NameLink]
}

struct GameIndices{
    let gameIndex: Int
    let generation: NameLink
}

struct Pokemon{
    let pokemon: NameLink
    let slot: Int
}

struct NameLink {
    let name: String
    let url: String
}





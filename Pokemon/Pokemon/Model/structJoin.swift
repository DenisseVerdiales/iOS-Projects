//
//  structjson.swift
//  Superpokemonapp
//
//  Created by Consultant on 7/14/22.
//
import Foundation


//Main link
struct Pokemonapi: Decodable{
    let next: String?
    let previous: String?
    let results: [Pokemon]
   
}

struct Pokemon: Decodable{
    let name: String
    let url: String
    let detail: [PokemonDetail]?
}

//Pokemon Link
struct PokemonDetail: Decodable{
    var abilities: [Abilities]
    var name: String
    var id: Int
    var moves:[Moves]
    var species: url
    var sprites: Sprites
    var stats:[Stats]
    var types:[Types]
}


struct Abilities: Decodable{
    let ability: nameLink
}

struct Types: Decodable{
    let slot: Int
    let type: nameLink
}

struct Moves: Decodable{
    let move: nameLink
   // let movelink: Movelink
}

struct Sprites: Decodable{
    let frontDefault: String
       
   /// The shiny depiction of this Pokémon from the front in battle.
    let frontShiny: String?
   
   /// The female depiction of this Pokémon from the front in battle.
    let frontFemale: String?
   
   /// The shiny female depiction of this Pokémon from the front in battle.
    let frontShinyFemale: String?
   
   /// The default depiction of this Pokémon from the back in battle.
    let backDefault: String
   
   /// The shiny depiction of this Pokémon from the back in battle.
    let backShiny: String?
   
   /// The female depiction of this Pokémon from the back in battle.
    let backFemale: String?
   
   /// The shiny female depiction of this Pokémon from the back in battle.
    let backShinyFemale: String?
    
    let other: Others
}

struct Stats: Decodable{
    let effort: Int
    let baseStat: Float
    let stat: nameLink
}

struct Others: Decodable{
    let home: Home

}

struct Home: Decodable{
    let front_default: String?
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
    
}

//link move
struct Movelink: Decodable{
    let effect_entries:[effect]
}

struct effect: Decodable{
    let effect: String
}

struct url: Decodable{
    let url: String
   // let specie: Specie?
}

//additional details
struct Specie: Decodable{
    let is_baby: Bool
    let is_legendary: Bool
    let is_mythical: Bool
}

struct nameLink:Decodable{
    let name: String
    let url: String
}



/**
 https://pokeapi.co/api/v2/pokemon?offset=0&limit=30
 https://pokeapi.co/api/v2/pokemon/1/
 https://pokeapi.co/api/v2/ability/65/
 https://pokeapi.co/api/v2/pokemon-species/1/
 */
 






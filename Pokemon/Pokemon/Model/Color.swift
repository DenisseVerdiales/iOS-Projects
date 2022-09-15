//
//  Color.swift
//  Pokemon
//
//  Created by Consultant on 7/18/22.
//

import UIKit


func color(pokemonDetail: PokemonDetail?) -> UIColor {
    
    var color: UIColor = .red
    
    if (pokemonDetail?.types[0].type.name == "grass"){
        color = .green
    }
    else if(pokemonDetail?.types[0].type.name == "poison"){
        color = .purple
    }
    else if(pokemonDetail?.types[0].type.name == "fire"){
        color = .red
    }
    else if(pokemonDetail?.types[0].type.name == "water"){
        color = .blue
    }
    else if(pokemonDetail?.types[0].type.name == "electric"){
        color = .yellow
    }
    else if(pokemonDetail?.types[0].type.name == "ice"){
        color = .systemIndigo
    }
    else if(pokemonDetail?.types[0].type.name == "normal"){
        color = .gray
    }
    else if(pokemonDetail?.types[0].type.name == "flying"){
        color = .systemCyan
    }
    else if(pokemonDetail?.types[0].type.name == "psychic"){
        color = .systemPink
    }
    else if(pokemonDetail?.types[0].type.name == "bug"){
        color = .systemMint
    }
    else if(pokemonDetail?.types[0].type.name == "rock"){
        color = .systemBrown
    }
    else if(pokemonDetail?.types[0].type.name == "fighting"){
        color = .systemOrange
    }
    else if(pokemonDetail?.types[0].type.name == "ghost"){
        color = .systemGray6
    }
    else if(pokemonDetail?.types[0].type.name == "dark"){
        color = .systemGray6
    }
    else if(pokemonDetail?.types[0].type.name == "dragon"){
        color = .systemPurple
        
    }
    else if(pokemonDetail?.types[0].type.name == "steel"){
        color = .darkGray
    }
    else if(pokemonDetail?.types[0].type.name == "fairy"){
        color = .systemPink
    }
    
   return color
}

func colorBorder(pokemonDetail: PokemonDetail?, border: Bool = false) -> CGColor {
    
    var color: CGColor = UIColor.red.cgColor
    
    if (pokemonDetail?.types[0].type.name == "grass"){
        color = UIColor.green.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "poison"){
        color = UIColor.purple.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "fire"){
        color = UIColor.red.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "water"){
        color = UIColor.blue.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "electric"){
        color = UIColor.yellow.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "ice"){
        color = UIColor.systemIndigo.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "normal"){
        color = UIColor.gray.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "flying"){
        color = UIColor.systemCyan.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "psychic"){
        color = UIColor.systemPink.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "bug"){
        color = UIColor.systemMint.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "rock"){
        color = UIColor.systemBrown.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "fighting"){
        color = UIColor.systemOrange.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "ghost"){
        color = UIColor.systemGray6.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "dark"){
        color = UIColor.systemGray6.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "dragon"){
        color = UIColor.systemPurple.cgColor
        
    }
    else if(pokemonDetail?.types[0].type.name == "steel"){
        color = UIColor.darkGray.cgColor
    }
    else if(pokemonDetail?.types[0].type.name == "fairy"){
        color = UIColor.systemPink.cgColor
    }
    
   return color
}

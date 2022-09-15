//
//  NetworkManager.swift
//  HardJSONDecodingAssignment
//
//  Created by Denisse Verdiales on 12/07/22.
//

import Foundation


class NetworkManager {
    
    func getDragonManually() -> Dragon? {
          
          guard let path = Bundle.main.path(forResource: "Damage", ofType: "json") else { return nil }
          
          do {
              let data = try Data(contentsOf: URL(fileURLWithPath: path))
              let jsonObj = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
              guard let baseDict = jsonObj as? [String: Any] else { return nil }
              return parseDragonManually(base: baseDict)
          } catch {
              print(error)
          }
          
          return nil
      }
    
    private func parseDragonManually(base: [String: Any]) -> Dragon? {
        
        guard let damageRelationsArr = base["damage_relations"] as? [String: Any] else { return nil }
        
        guard let doubleDamageFromArr = damageRelationsArr["double_damage_from"] as? [[String: Any]] else { return nil }
        var finalDoubleDamageFrom: [NameLink] = []
        doubleDamageFromArr.forEach { value in
        guard let doubleDamageF = self.createNameLink(dict: value) else { return }
            finalDoubleDamageFrom.append(doubleDamageF)
        }
        
        guard let doubleDamageToArr = damageRelationsArr["double_damage_to"] as? [[String: Any]] else { return nil }
        var finaldoubleDamageTo: [NameLink] = []
        doubleDamageToArr.forEach { value in
           guard let ddt = self.createNameLink(dict: value) else { return }
            finaldoubleDamageTo.append(ddt)
        }
        
        guard let halfDamageFromArr = damageRelationsArr["half_damage_from"] as? [[String: Any]] else { return nil }
        var finalhalfDamageFrom: [NameLink] = []
        halfDamageFromArr.forEach { value in
           guard let hdf = self.createNameLink(dict: value) else { return }
            finalhalfDamageFrom.append(hdf)
        }
        
        guard let halfDamageToArr = damageRelationsArr["half_damage_to"] as? [[String: Any]] else { return nil }
        var finalhalfDamageTo: [NameLink] = []
        halfDamageToArr.forEach { value in
           guard let hdt = self.createNameLink(dict: value) else { return }
            finalhalfDamageTo.append(hdt)
        }
        
        guard let noDamageFromArr = damageRelationsArr["no_damage_from"] as? [[String: Any]] else { return nil }
        var finalnoDamageFrom: [NameLink] = []
        noDamageFromArr.forEach { value in
           guard let ndf = self.createNameLink(dict: value) else { return }
            finalnoDamageFrom.append(ndf)
        }
        
        guard let noDamageToArr = damageRelationsArr["no_damage_to"] as? [[String: Any]] else { return nil }
        var finalnoDamageTo: [NameLink] = []
        noDamageToArr.forEach { value in
           guard let ndt = self.createNameLink(dict: value) else { return }
            finalnoDamageTo.append(ndt)
        }
        
        let damage = DamageRelations(
            doubleDamageFrom: finalDoubleDamageFrom,
            doubleDamageTo: finaldoubleDamageTo,
            halfDamageFrom: finalhalfDamageFrom,
            halfDamageTo: finalhalfDamageTo,
            noDamageFrom: finalnoDamageFrom,
            noDamageTo: finalnoDamageTo
        )
        
        guard let gameIndicesArr = base["game_indices"] as? [[String: Any]] else { return nil }
        var finalGameIndices: [GameIndices] = []
        gameIndicesArr.forEach { value in
           guard let generationDict = value["generation"] as? [String: Any] else { return }
           guard let generationRep = self.createNameLink(dict: generationDict) else { return }
           guard let gameIndexValue = value["game_index"] as? Int else { return }
            finalGameIndices.append(GameIndices(gameIndex: gameIndexValue, generation: generationRep))
        }
        
        guard let generationDict = base["generation"] as? [String: Any] else { return nil }
        guard let gen = self.createNameLink(dict: generationDict) else { return nil }
     
        guard let Id = base["id"] as? Int else { return nil }
    
        guard let moveDamageClassDict = base["move_damage_class"] as? [String: Any] else { return nil }
        guard let movDamageC = self.createNameLink(dict: moveDamageClassDict) else { return nil }
        
        guard let movesArr = base["moves"] as? [[String: Any]] else { return nil }
        var finalMoves: [NameLink] = []
        movesArr.forEach { value in
           guard let moves = self.createNameLink(dict: value) else { return }
            finalMoves.append(moves)
        }

        guard let name = base["name"] as? String else { return nil }

        guard let pokemonArr = base["pokemon"] as? [[String: Any]] else { return nil }
        var finalPokemon: [Pokemon] = []
        pokemonArr.forEach { value in
           guard let pokemonDict = value["pokemon"] as? [String: Any] else { return }
           guard let pokemonRep = self.createNameLink(dict: pokemonDict) else { return }
           guard let slotValue = value["slot"] as? Int else { return }
            finalPokemon.append(Pokemon(pokemon: pokemonRep, slot: slotValue))
        }
        
        return Dragon(damageRelations: damage, gameIndices: finalGameIndices, generation: gen, id: Id, moveDamageClass: movDamageC, moves: finalMoves, name: name, pokemon: finalPokemon)
        
    }

    private func createNameLink(dict: [String: Any]) -> NameLink? {
          guard let name = dict["name"] as? String else { return nil }
          guard let url = dict["url"] as? String else { return nil }
          return NameLink(name: name, url: url)
      }
}

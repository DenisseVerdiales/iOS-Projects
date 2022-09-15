//
//  pageResult.swift
//  RickAndMortySwiftyUI
//
//  Created by Consultant on 8/21/22.
//

import Foundation

struct PageResult: Decodable {
    let results: [Results]
    
    enum CodinKeys: String, CodingKey{
        case results
    }
}

struct Results: Decodable, Hashable {
    let id:Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: NameLink
    let image: String
    let location: NameLink
    
    enum CodinKeys: String, CodingKey{
        case id, name, status, species, gender, origin, image,location
    }
}

struct NameLink: Decodable, Hashable {
    let name: String
    let url: String

    enum CodinKeys: String, CodingKey{
        case name, url
    }
}

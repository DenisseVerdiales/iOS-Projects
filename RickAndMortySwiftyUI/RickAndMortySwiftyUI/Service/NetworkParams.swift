//
//  NetworkParams.swift
//  RickAndMortySwiftyUI
//
//  Created by Consultant on 8/21/22.
//

import Foundation

enum NetworkParams{
    
    private struct NetworkConstants{
        static let rickAndMortyBase = "https://rickandmortyapi.com/api/character"
    }
    
    case character(Int)
    case image(String)
    
    var url: URL?{
        switch self {
        case .character(let page):
            var components = URLComponents(string: NetworkConstants.rickAndMortyBase)
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
            components?.queryItems = queryItems
            
            return components?.url
        case .image(let path):
            return URL(string: path)
        }
    }
    
}


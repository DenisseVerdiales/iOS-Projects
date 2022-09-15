//
//  albumModel.swift
//  iTunes
//
//  Created by Consultant on 7/22/22.
//

import Foundation

struct AlbumPage: Decodable{
    let feed: Feed
}

struct Feed: Decodable{
    let results: [Results]
    
}

struct Results: Decodable{
    var Id: Int?
    let artistName: String
    let name: String
    let releaseDate: String
    let artworkUrl100: String
    let genres: [Genres]
}

struct Genres: Decodable{
    let name: String
}

struct Favorite: Decodable{
    var Id: Int
    var favoriteA: Bool
}

enum selectColorFav {
    case liked
    case disLiked
}

//
//  NetworkError.swift
//  RickAndMortySwiftyUI
//
//  Created by Consultant on 8/21/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidStatusCode(Int)
    case generalError(Error)
}

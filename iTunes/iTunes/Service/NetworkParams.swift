//
//  NetworkParams.swift
//  iTunes
//
//  Created by Consultant on 7/22/22.
//

import Foundation

enum NetworkParams {
    
    private struct NetworkConstants {
        static let albumBase = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/100/albums.json"
       
    }
    case albumMusic
    case albumImage(String)
    
    var url: URL? {
        switch self {
        case .albumMusic:
            let component = URL(string: NetworkConstants.albumBase)
          
            return component
        case .albumImage(let urlImg):
            return URL(string: urlImg)
//            let baseURL = URL(string: NetworkConstants.baseImage)
//            return URL(string: posterPath, relativeTo: baseURL)
        
        }
    }
    
}

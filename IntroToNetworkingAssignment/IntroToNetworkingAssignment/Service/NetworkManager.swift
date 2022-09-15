//
//  NetworkManager.swift
//  IntroToNetworkingAssignment
//
//  Created by Denisse Verdiales on 11/07/22.
//

import Foundation

// MARK: 3 key things to make a PERFECT singleton;
//1: use Final to prevent subclassing
//2: use static property of itself,
//3: private init to prevent other instances created

//Non-perfect singleton only require point 2 above

final class NetworkManager{
    static let shared: NetworkManager = NetworkManager()
    
    private let session: URLSession
    
    private init(session: URLSession = URLSession.shared){
        self.session = session
    }
    
    func getData(url: URL?, completion: @escaping (Data?, URLResponse) -> Void){
        
        guard let url = url else {return}
        
        self.session.dataTask(with: url){data, response, error in
            
            completion(data,response ?? URLResponse())
            
        }.resume()
        
    }
}

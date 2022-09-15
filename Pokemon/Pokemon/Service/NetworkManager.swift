//
//  NetworkM.swift
//  Superpokemonapp
//
//  Created by Consultant on 7/15/22.
//
import Foundation



final class NetworkManager{
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session

    }
}


extension NetworkManager{
    func getPokemonList(urlStrg: String, callback: @escaping (Result<Pokemonapi, NetworkError>) -> Void) {
            guard let url = URL(string: urlStrg) else {
                callback(.failure(.dataFailure))
                return
            }

            let task = session.dataTask(with: url) { data, response, error in

                // Check that we didn't screw up.
                if let error = error {
                    callback(.failure(.other(error.localizedDescription)))
                    return
                }

                // Check that the response is an HTTP response (i.e., web).
                guard let httpResp = response as? HTTPURLResponse else {
                    callback(.failure(.other("Not a HTTP response")))
                    return
                }

                // Check that we got the "OK" response code (~200).
                guard (200..<300).contains(httpResp.statusCode) else {
                    callback(.failure(.statusNotOk(httpResp.statusCode)))
                    return
                }

                // Check that the data isn't nil.
                guard let data = data else {
                    callback(.failure(.dataFailure))
                    return
                }

                // Make a decoder...
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                // ... and try to decode that data!
                do {
                    let result = try decoder.decode(Pokemonapi.self, from: data)
                    callback(.success(result))
                } catch {
                    callback(.failure(.decodeFailure(error)))
                    return
                }
            }
            task.resume()
        }

        func getPokemon(url: String, callback: @escaping (Result<PokemonDetail, NetworkError>) -> Void) {
            guard let url = URL(string: url) else {
                callback(.failure(.urlFailure))
                return
            }

            let task = session.dataTask(with: url) { data, response, error in

                // Check that we didn't screw up.
                if let error = error {
                    callback(.failure(.other(error.localizedDescription)))
                    return
                }

                // Check that the response is an HTTP response (i.e., web).
                guard let httpResp = response as? HTTPURLResponse else {
                    callback(.failure(.other("Not a HTTP response")))
                    return
                }

                // Check that we got the "OK" response code (~200).
                guard (200..<300).contains(httpResp.statusCode) else {
                    callback(.failure(.statusNotOk(httpResp.statusCode)))
                    return
                }

                // Check that the data isn't nil.
                guard let data = data else {
                    callback(.failure(.dataFailure))
                    return
                }

                // Make a decoder...
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                // ... and try to decode that data!
                do {
                    let result = try decoder.decode(PokemonDetail.self, from: data)
                    callback(.success(result))
                } catch {
                    callback(.failure(.decodeFailure(error)))
                    return
                }
            }
            task.resume()
        }
    
    func fetchImageData(urlStr: URL?, completion: @escaping (Data?) -> Void) {

           guard let url2 =  urlStr else {return}

           self.session.dataTask(with: url2) { data, response, error in
               completion(data)
           }.resume()
    }
    
    func fetchImageData1(urlStr: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
            
        guard let url = URL(string: urlStr) else {
            completion(.failure(NetworkError.urlFailure))
            return
        }
        
        self.session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(NetworkError.other("error")))
                return
            }
            
            if let hResponse = response as? HTTPURLResponse, !(200..<300).contains(hResponse.statusCode) {
                completion(.failure(NetworkError.serverResponse(hResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }
            
            completion(.success(data))

        }.resume()
        
    }
    
}

   


   
    



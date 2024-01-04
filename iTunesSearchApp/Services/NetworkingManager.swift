//
//  NetworkingManager.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/01/2024.
//

import Foundation
import Combine

class NetworkingManager{
    
//    func fetchAlbums(searchTerm: String, page: Int, limit: Int)-> AnyPublisher<AlbumResult, Error>{
//        let url = createURL(for: searchTerm,type: .album, page: page, limit: limit)
//        fetch(type: AlbumResult.self, url: url)
//    }
    func fetchAlbums(searchTerm: String, page: Int, limit: Int) -> AnyPublisher<AlbumResult, Error> {
        guard let url = createURL(for: searchTerm, type: .album, page: page, limit: limit) else {
            return Fail(error: APIError.unknown).eraseToAnyPublisher()
        }
        return fetch(type: AlbumResult.self, url: url)
            .mapError { $0 as Error } // Convert APIError to Error
            .eraseToAnyPublisher()
    }
    
    func fetchSongs(searchTerm: String) -> AnyPublisher<SongResult, Error> {
        guard let url = createURL(for: searchTerm, type: .song, page: nil, limit: nil) else {
            return Fail(error: APIError.unknown).eraseToAnyPublisher()
        }
        return fetch(type: SongResult.self, url: url)
            .mapError { $0 as Error } // Convert APIError to Error
            .eraseToAnyPublisher()
    }
    
    func fetchMovies(searchTerm: String) -> AnyPublisher<MovieResult, Error> {
        guard let url = createURL(for: searchTerm, type: .movie, page: nil, limit: nil) else {
            return Fail(error: APIError.unknown).eraseToAnyPublisher()
        }
        return fetch(type: MovieResult.self, url: url)
            .mapError { $0 as Error } // Convert APIError to Error
            .eraseToAnyPublisher()
    }
//    func fetchSongs(searchTerm: String, page: Int, limit: Int)-> AnyPublisher<SongResult, Error>{
//        let url = createURL(for: searchTerm,type: .song, page: page, limit: limit)
//        fetch(type: SongResult.self, url: url)
//    }
//    
//    func fetchMovies(searchTerm: String, page: Int, limit: Int)-> AnyPublisher<MovieResult, Error>{
//        let url = createURL(for: searchTerm,type: .movie, page: page, limit: limit)
//        fetch(type: MovieResult.self, url: url)
//    }
    
    
     func fetch<T: Decodable>(type: T.Type , url: URL)  -> AnyPublisher<T, APIError>{
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else{
                    throw APIError.unknown
                }
                return output.data
            }
            .retry(3)
            .decode(type: type.self, decoder: JSONDecoder())
            .mapError { error in
                APIError.decodingError
            }
            .eraseToAnyPublisher()
    }

    
    func handleCompletion<E: Error>(_ completion: Subscribers.Completion<E>) {
        switch completion {
        case .finished:
            print("success")
        case .failure(let error):
            if let apiError = error as? APIError {
                print(apiError.localizedDescription)
            } else {
                print("An unknown error occurred")
            }
        }
    }
    
    
    func createURL(for searchTerm: String , type: EntityType, page: Int?, limit: Int?) -> URL?{
        let baseUrl = "https://itunes.apple.com/search"
        
        
        var queryItems = [URLQueryItem(name: "term", value: searchTerm),
                          URLQueryItem(name: "entity", value: type.rawValue)
                         ]
        if let page = page , let limit = limit {
            let offset = page * limit
            queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
            queryItems.append(URLQueryItem(name: "offset", value: String(offset)))

        }
        var components = URLComponents(string: baseUrl)
        components?.queryItems = queryItems
        return components?.url
    }
}




//     func handleCompletion(_ completion: Subscribers.Completion<APIError>){
//        switch completion{
//        case .finished:
//            print("success")
//        case .failure(let error):
//            print(error.localizedDescription)
//        }
//    }

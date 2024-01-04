//
//  APIError.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/01/2024.
//

import Foundation

enum APIError : Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError : LocalizedError {
    var errorDescription: String?{
        switch self {
        case .decodingError :
            return "Failed to decode the object from the service"
        case .errorCode(let code) :
            return "\(code), Something went wrong"
        case .unknown:
            return "unknown error is occured"
        }
    }
}

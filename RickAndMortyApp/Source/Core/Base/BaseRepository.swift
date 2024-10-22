//
//  BaseRepository.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

import Foundation
import Combine

class BaseRepository {
    
    private let urlSession: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .useProtocolCachePolicy
        self.urlSession = URLSession(configuration: configuration)
    }
    
    enum RepositoryError: Error {
        case invalidUrl
        case invalidResponse
        case invalidData
        case emptyData
        case unsuccessfulCode
    }
    
    enum ErrorResponse: Error {
        case error(Int, Data?, Error)
        
        var code: Int {
            switch self {
            case .error(let code, _, _):
                return code
            }
        }
    }
    
    // Combine version
    func executeRequestByUrl<T: Codable, S>(_ urlString: String,
                                            queryItems: [URLQueryItem]? = nil,
                                   mapFunction: @escaping (T) throws -> (S)) -> Observable<S> {
        Deferred {
            Future<T, Error> { promise in
                var url: URL?
                if let queryItems = queryItems {
                    var urlComponents = URLComponents(string: urlString)
                    urlComponents?.queryItems = queryItems.filter { $0.value != nil && $0.value?.isEmpty == false}
                    url = urlComponents?.url
                } else {
                    url = URL(string: urlString)
                }
                guard let url = url else {
                    promise(.failure(RepositoryError.invalidUrl))
                    return
                }
                NetworkLogger.log(url: url)
                
                let dataTask = self.urlSession.dataTask(with: url) { data, response, error in
                    NetworkLogger.log(response: response as? HTTPURLResponse, data: data, error: error)
                    if let error {
                        promise(.failure(ErrorResponse.error(-1, data, error)))
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse else {
                        promise(.failure(ErrorResponse.error(-2, data, RepositoryError.invalidResponse)))
                        return
                    }
                    guard httpResponse.isStatusCodeSuccessful else {
                        promise(.failure(ErrorResponse.error(httpResponse.statusCode, data, RepositoryError.unsuccessfulCode)))
                        return
                    }
                    guard let data, !data.isEmpty else {
                        promise(.failure(ErrorResponse.error(httpResponse.statusCode, data, RepositoryError.emptyData)))
                        return
                    }
                    do {
//                        let decoder = JSONDecoder()
//                        decoder.dateDecodingStrategy = .custom({ decoder in
//                            let container = try decoder.singleValueContainer()
//                            let dateString = try container.decode(String.self)
//                            if let date = DateFormatter.createdDateFormatter.date(from: dateString) {
//                                return date
//                            }
//                            if let date = DateFormatter.airDateDateFormatter.date(from: dateString) {
//                                return date
//                            }
//                            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
//                        })
                        let response = try JSONDecoder().decode(T.self, from: data)
                        promise(.success(response))
                    } catch {
                        promise(.failure(ErrorResponse.error(httpResponse.statusCode, data, RepositoryError.invalidData)))
                    }
                }
                dataTask.resume()
            }
        }
        .tryMap(mapFunction)
        .asObservable()
    }
    
    // async/await version
    func executeRequestByUrl<T: Codable, S>(_ urlString: String,
                                   mapFunction: @escaping (T) throws -> (S)) async throws -> S {
        guard let url = URL(string: urlString) else {
            throw RepositoryError.invalidUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ErrorResponse.error(-2, data, RepositoryError.invalidResponse)
        }
        guard httpResponse.isStatusCodeSuccessful else {
            throw ErrorResponse.error(httpResponse.statusCode, data, RepositoryError.unsuccessfulCode)
        }
        guard !data.isEmpty else {
            throw ErrorResponse.error(httpResponse.statusCode, data, RepositoryError.emptyData)
        }
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return try mapFunction(decodedResponse)
        } catch {
            throw ErrorResponse.error(httpResponse.statusCode, data, RepositoryError.invalidData)
        }
    }
}


extension HTTPURLResponse {
    var isStatusCodeSuccessful: Bool {
        return (200 ..< 300).contains(statusCode)
    }
}

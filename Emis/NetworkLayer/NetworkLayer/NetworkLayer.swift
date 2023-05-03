//
//  NetworkLayer.swift
//  NetworkLayer
//
//  Created by Shio Birbichadze on 03.05.23.
//

import Combine

protocol NetworkLayer {
    func makeRequest<T: Decodable, R: Endpoint>(_ endpoint: R) -> AnyPublisher<T, Error> where R.Response == T
}

class NetworkManager: NetworkLayer {
    
    func makeRequest<T: Decodable, R: Endpoint>(_ endpoint: R) -> AnyPublisher<T, Error> where R.Response == T {
        guard let url = endpoint.url else {
            let error = NetworkError.invalidURL
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        if let headers = endpoint.headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    let error = NetworkError.httpError(statusCode: httpResponse.statusCode)
                    throw error
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    return try decoder.decode(T.self, from: data)
                } catch {
                    throw NetworkError.decodingError
                }
            }
            .mapError { error -> Error in
                error is NetworkError ? error : NetworkError.decodingError
            }
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error {
    case invalidURL
    case serializationError
    case invalidResponse
    case decodingError
    case unknown
    case httpError(statusCode: Int)
}

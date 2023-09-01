//
//  NetworkLayer.swift
//  NetworkLayer
//
//  Created by Shio Birbichadze on 03.05.23.
//

import Combine

public protocol NetworkLayer {
    func makeRequest<T: Decodable, R: Endpoint>(_ endpoint: R) -> AnyPublisher<T, Error> where R.Response == T
}

public class NetworkManager: NetworkLayer {
    
    public init() { }
    
    public func makeRequest<T: Decodable, R: Endpoint>(_ endpoint: R) -> AnyPublisher<T, Error> where R.Response == T {
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
            .timeout(30, scheduler: DispatchQueue.main)
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
                if let urlError = error as? URLError, urlError.code == .timedOut {
                    return NetworkError.timeout
                }
                return error is NetworkError ? error : NetworkError.decodingError
            }
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error {
    case timeout
    case invalidURL
    case serializationError
    case invalidResponse
    case decodingError
    case unknown
    case httpError(statusCode: Int)
}

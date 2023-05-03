//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Shio Birbichadze on 03.05.23.
//

import Combine

// for using this network layer by dependency Injection
class NetworkService: NetworkLayer {
    private let networkManager: NetworkLayer
    
    init(networkManager: NetworkLayer = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func makeRequest<T: Decodable, R: Endpoint>(_ endpoint: R) -> AnyPublisher<T, Error> where R.Response == T {
        networkManager.makeRequest(endpoint)
    }
}

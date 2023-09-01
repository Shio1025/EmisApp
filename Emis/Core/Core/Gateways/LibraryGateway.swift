//
//  LibraryGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 01.09.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol LibraryGateway {
    func getBooks(title: String,
                  author: String,
                  page: Int,
                  size: Int) -> AnyPublisher<Library, Error>
}

public class LibraryGatewayImpl: LibraryGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func getBooks(title: String,
                         author: String,
                         page: Int,
                         size: Int) -> AnyPublisher<Library, Error> {
        
        let url = apiURLProvider.getURL(path: "/emis/api/library/find",
                                        params: ["title": title,
                                                 "author": author,
                                                 "page": page.description,
                                                 "size": size.description])
        
        let endpoint = EndPoint<ApiLibraryModel>(url: url,
                                                 method: .get)
        
        let publisher: AnyPublisher<Library, Error> = dataTransport.makeRequest(endpoint)
            .map { model in
                return Library(with: model)
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

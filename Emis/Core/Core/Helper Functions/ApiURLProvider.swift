//
//  ApiGeneralParamsProvider.swift
//  Core
//
//  Created by Shio Birbichadze on 26.08.23.
//

protocol ApiURLProvider {
    func getURL(path: String,
                params: [String: String]) -> URL?
}

struct ApiUURLProviderImpl: ApiURLProvider {
    
    func getURL(path: String,
                params: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = domainURL
        components.path = path
        components.queryItems = params.map({ key, value in
            URLQueryItem(name: key, value: value)
        })
        return components.url
    }
    
    private var domainURL: String {
        ""
    }
}

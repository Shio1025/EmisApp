//
//  Endpoint.swift
//  NetworkLayer
//
//  Created by Shio Birbichadze on 03.05.23.
//

public protocol Endpoint {
    associatedtype Response
    
    var url: URL? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: [String: Any]? { get }
}


public class EndPoint<T: Decodable>: Endpoint {
    public typealias Response = T
    
    public let url: URL?
    public let method: HTTPMethod
    public let headers: [String: String]?
    public let body: [String: Any]?
    
    public init(url: URL?,
                method: HTTPMethod,
                headers: [String: String]? = nil,
                body: [String: Any]? = nil) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

//
//  RegisterSubjectGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol RegisterSubjectGateway {
    func registerSubject(studentId: String,
                         courseId: String) -> AnyPublisher<Void, Error>
}

public class RegisterSubjectGatewayImpl: RegisterSubjectGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func registerSubject(studentId: String,
                                courseId: String) -> AnyPublisher<Void, Error> {
        
        let url = apiURLProvider.getURL(path: "/emis/api/courseRegistration/register",
                                        params: ["studentId": studentId,
                                                 "courseId": courseId])
        
        let endpoint = EndPoint<Int>(url: url,
                                    method: .post)
        
        let publisher: AnyPublisher<Void, Error> = dataTransport.makeRequest(endpoint)
            .map { model in
                return Void()
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

struct CoolResponse: Codable {
    let message: String
}

//
//  GetRegisteredSubjectsGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol GetRegisteredSubjectsGateway {
    func getSubjects(studentId: String) -> AnyPublisher<[RegisteredSubject], Error>
}

public class GetRegisteredSubjectsGatewayImpl: GetRegisteredSubjectsGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func getSubjects(studentId: String) -> AnyPublisher<[RegisteredSubject], Error> {
        
        let url = apiURLProvider.getURL(path: "/emis/api/courseRegistration/registeredCourses",
                                        params: ["studentId": studentId])
        
        let endpoint = EndPoint<[ApiRegisteredSubject]>(url: url,
                                       method: .get)
        
        let publisher: AnyPublisher<[RegisteredSubject], Error> = dataTransport.makeRequest(endpoint)
            .map { model in
                return model.map { RegisteredSubject(with: $0) }
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}


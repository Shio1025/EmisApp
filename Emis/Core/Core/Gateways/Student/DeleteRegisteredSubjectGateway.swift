//
//  DeleteRegisteredSubjectGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol DeleteRegisteredSubjectGateway {
    func deleteSubject(studentId: String,
                       courseId: String) -> AnyPublisher<[RegisteredSubject], Error>
}

public class DeleteRegisteredSubjectGatewayImpl: DeleteRegisteredSubjectGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func deleteSubject(studentId: String,
                              courseId: String) -> AnyPublisher<[RegisteredSubject], Error> {
        
        let url = apiURLProvider.getURL(path: "/emis/api/courseRegistration/deleteRegisteredCourse",
                                        params: ["studentId": studentId,
                                                 "courseId": courseId])
        
        let endpoint = EndPoint<[ApiRegisteredSubject]>(url: url,
                                                        method: .delete)
        
        let publisher: AnyPublisher<[RegisteredSubject], Error> = dataTransport.makeRequest(endpoint)
            .map { model in
                return model.map { RegisteredSubject(with: $0) }
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

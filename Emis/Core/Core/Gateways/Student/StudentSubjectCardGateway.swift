//
//  StudentSubjectCardGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol StudentSubjectCardGateway {
    func getStudentSubjectCardInfo(userId: String) -> AnyPublisher<StudentSubjectCard, Error>
}

public class StudentSubjectCardGatewayImpl: StudentSubjectCardGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func getStudentSubjectCardInfo(userId: String) -> AnyPublisher<StudentSubjectCard, Error> {
        
        let url = apiURLProvider.getURL(path: "/emis/api/student/subjectCard",
                                        params: ["id": userId])
        
        let endpoint = EndPoint<ApiStudentSubjectCard>(url: url,
                                                       method: .get)
        
        let publisher: AnyPublisher<StudentSubjectCard, Error> = dataTransport.makeRequest(endpoint)
            .map { model in
                return StudentSubjectCard(with: model)
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

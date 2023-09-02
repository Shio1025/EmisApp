//
//  TeacherSubjectCardGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 02.09.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol TeacherSubjectCardGateway {
    func getTeacherSubjectCardInfo(userId: String) -> AnyPublisher<TeacherSubjectCard, Error>
}

public class TeacherSubjectCardGatewayImpl: TeacherSubjectCardGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func getTeacherSubjectCardInfo(userId: String) -> AnyPublisher<TeacherSubjectCard, Error> {
        
        let url = apiURLProvider.getURL(path: "/emis/api/teacher/courses",
                                        params: ["teacherId": userId])
        
        let endpoint = EndPoint<ApiTeacherSubjectCard>(url: url,
                                                       method: .get)
        
        let publisher: AnyPublisher<TeacherSubjectCard, Error> = dataTransport.makeRequest(endpoint)
            .map { model in
                return TeacherSubjectCard(with: model)
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

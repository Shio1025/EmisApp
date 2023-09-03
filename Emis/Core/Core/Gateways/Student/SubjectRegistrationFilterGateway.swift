//
//  SubjectRegistrationFilterGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol SubjectRegistrationFilterGateway {
    func getSubjects(studentId: String,
                  subjectName: String,
                  page: Int,
                  size: Int) -> AnyPublisher<SubjectRegistrationFilter, Error>
}

public class SubjectRegistrationFilterGatewayImpl: SubjectRegistrationFilterGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func getSubjects(studentId: String,
                            subjectName: String,
                            page: Int,
                            size: Int) -> AnyPublisher<SubjectRegistrationFilter, Error> {
        
        let url = apiURLProvider.getURL(path: "/emis/api/course/filter",
                                        params: ["studentId": studentId,
                                                 "subjectName": subjectName,
                                                 "page": page.description,
                                                 "size": size.description])
        
        let endpoint = EndPoint<ApiSubjectRegistrationFilter>(url: url,
                                                 method: .get)
        
        let publisher: AnyPublisher<SubjectRegistrationFilter, Error> = dataTransport.makeRequest(endpoint)
            .map { model in
                return SubjectRegistrationFilter(with: model)
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}


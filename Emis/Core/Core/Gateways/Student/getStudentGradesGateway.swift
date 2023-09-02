//
//  getStudentGradesGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 02.09.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol getStudentGradesGateway {
    func getStudentGrades(courseId: String,
                          studentId: String) -> AnyPublisher<[StudentGrade], Error>
}

public class getStudentGradesGatewayImpl: getStudentGradesGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func getStudentGrades(courseId: String,
                                 studentId: String) -> AnyPublisher<[StudentGrade], Error> {
        
        let url = apiURLProvider.getURL(path: "/emis/api/student/course/grades",
                                        params: ["courseId": courseId,
                                                 "studentId": studentId])
        
        let endpoint = EndPoint<[ApiStudentGrade]>(url: url,
                                                   method: .get)
        
        let publisher: AnyPublisher<[StudentGrade], Error> = dataTransport.makeRequest(endpoint)
            .map { model in
                return model.map { elem in
                    StudentGrade(with: elem)
                }
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

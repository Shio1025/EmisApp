//
//  StudentCourseInfoGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//


import NetworkLayer
import Combine
import Resolver

public protocol StudentCourseInfoGateway {
    func getStudentCourseInfo(courseId: String,
                              studentId: String) -> AnyPublisher<StudentCourseInfo, Error>
}

public class StudentCourseInfoGatewayImpl: StudentCourseInfoGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func getStudentCourseInfo(courseId: String,
                                     studentId: String) -> AnyPublisher<StudentCourseInfo, Error> {
        
        let url = apiURLProvider.getURL(path: "/emis/api/course/detailsForStudent",
                                        params: ["courseId": courseId,
                                                 "studentId": studentId])
        
        let endpoint = EndPoint<ApiStudentCourseInfo>(url: url,
                                                      method: .get)
        
        let publisher: AnyPublisher<StudentCourseInfo, Error> = dataTransport.makeRequest(endpoint)
            .map { model in
                return StudentCourseInfo(with: model)
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

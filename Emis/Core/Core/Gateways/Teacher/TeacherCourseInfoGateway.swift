//
//  TeacherCourseInfoGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 02.09.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol TeacherCourseInfoGateway {
    func getTeacherCourseInfo(courseId: String) -> AnyPublisher<TeacherCourseInfo, Error>
}

public class TeacherCourseInfoGatewayImpl: TeacherCourseInfoGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func getTeacherCourseInfo(courseId: String) -> AnyPublisher<TeacherCourseInfo, Error> {
        
        let url = apiURLProvider.getURL(path: "/emis/api/course/detailsForTeacher",
                                        params: ["courseId": courseId])
        
        let endpoint = EndPoint<ApiTeacherCourseInfo>(url: url,
                                                         method: .get)
        
        let publisher: AnyPublisher<TeacherCourseInfo, Error> = dataTransport.makeRequest(endpoint)
            .map { model in
                return TeacherCourseInfo(with: model)
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

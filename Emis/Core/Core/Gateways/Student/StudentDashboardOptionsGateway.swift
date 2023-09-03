//
//  StudentDashboardOptionsGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol StudentDashboardOptionsGateway {
    func getStudentDashboardOptionsInfo(userId: String) -> AnyPublisher<StudentDashboardOptions, Error>
}

public class StudentDashboardOptionsGatewayImpl: StudentDashboardOptionsGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func getStudentDashboardOptionsInfo(userId: String) -> AnyPublisher<StudentDashboardOptions, Error> {
        
        let url = apiURLProvider.getURL(path: "/emis/api/dashboard/student/pages",
                                        params: ["studentId": userId])
        
        let endpoint = EndPoint<[String]>(url: url,
                                          method: .get)
        
        let publisher: AnyPublisher<StudentDashboardOptions, Error> = dataTransport.makeRequest(endpoint)
            .map { model in
                return StudentDashboardOptions(with: model)
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

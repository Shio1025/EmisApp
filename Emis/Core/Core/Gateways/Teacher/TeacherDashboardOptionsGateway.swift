//
//  TeacherDashboardOptionsGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol TeacherDashboardOptionsGateway {
    func getTeacherDashboardOptionsInfo(userId: String) -> AnyPublisher<TeacherDashboardOptions, Error>
}

public class TeacherDashboardOptionsGatewayImpl: TeacherDashboardOptionsGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func getTeacherDashboardOptionsInfo(userId: String) -> AnyPublisher<TeacherDashboardOptions, Error> {
        
        let url = apiURLProvider.getURL(path: "/emis/api/dashboard/teacher/pages",
                                        params: ["teacherId": userId])
        
        let endpoint = EndPoint<[String]>(url: url,
                                          method: .get)
        
        let publisher: AnyPublisher<TeacherDashboardOptions, Error> = dataTransport.makeRequest(endpoint)
            .map { model in
                return TeacherDashboardOptions(with: model)
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

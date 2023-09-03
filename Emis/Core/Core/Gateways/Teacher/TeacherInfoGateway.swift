//
//  TeacherInfoGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 30.08.23.
//
import NetworkLayer
import Combine
import Resolver

public protocol TeacherInfoGateway {
    func getTeacherInfo(userId: String) -> AnyPublisher<TeacherInfo, Error>
}

public class TeacherInfoGatewayImpl: TeacherInfoGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func getTeacherInfo(userId: String) -> AnyPublisher<TeacherInfo, Error> {
        let params = ["teacherId": userId]
        
        let url = apiURLProvider.getURL(path: "/emis/api/teacher",
                                        params: params)
        
        let endpoint = EndPoint<ApiTeacherInfo>(url: url,
                                                method: .get)
        
        let publisher: AnyPublisher<TeacherInfo, Error> = dataTransport.makeRequest(endpoint)
            .map { teacherModel in
                return TeacherInfo(with: teacherModel)
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

//
//  StudentInfoGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol StudentInfoGateway {
    func getStudentInfo(userId: String) -> AnyPublisher<StudentInfo, Error>
}

public class StudentInfoGatewayImpl: StudentInfoGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func getStudentInfo(userId: String) -> AnyPublisher<StudentInfo, Error> {
        let params = ["studentId": userId]
        
        let url = apiURLProvider.getURL(path: "/emis/api/student",
                                        params: params)
        
        let endpoint = EndPoint<ApiStudentInfo>(url: url,
                                               method: .get)
        
        let publisher: AnyPublisher<StudentInfo, Error> = dataTransport.makeRequest(endpoint)
            .map { studentModel in
                return StudentInfo(with: studentModel)
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

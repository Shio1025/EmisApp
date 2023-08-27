//
//  StudentFinancialGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol StudentFinancialGateway {
    func getStudentFinancialInfo(userId: String) -> AnyPublisher<StudentInfo, Error>
}

public class StudentFinancialGatewayImpl: StudentFinancialGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func getStudentFinancialInfo(userId: String) -> AnyPublisher<StudentInfo, Error> {
        let params = ["id": userId]
        
        let url = apiURLProvider.getURL(path: "/emis/api/student/finances",
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

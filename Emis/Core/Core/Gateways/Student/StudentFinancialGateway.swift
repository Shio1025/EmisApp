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
    func getStudentFinancialInfo(userId: String) -> AnyPublisher<StudentFinancials, Error>
}

public class StudentFinancialGatewayImpl: StudentFinancialGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func getStudentFinancialInfo(userId: String) -> AnyPublisher<StudentFinancials, Error> {
        let params = ["id": userId]
        
        let url = apiURLProvider.getURL(path: "/emis/api/student/finances",
                                        params: params)
        
        let endpoint = EndPoint<ApiStudentFinancials>(url: url,
                                               method: .get)
        
        let publisher: AnyPublisher<StudentFinancials, Error> = dataTransport.makeRequest(endpoint)
            .map { studentFinancesModel in
                return StudentFinancials(with: studentFinancesModel)
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

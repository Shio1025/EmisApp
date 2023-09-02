//
//  UpdateMarkGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 02.09.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol UpdateMarkGateway {
    func updateGrade(studentGradeId: String,
                            mark: String) -> AnyPublisher<Void, Error>
}

public class UpdateMarkGatewayImpl: UpdateMarkGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func updateGrade(studentGradeId: String,
                            mark: String) -> AnyPublisher<Void, Error> {
        
        let url = apiURLProvider.getURL(path: "/emis/api/student/update/mark",
                                        params: ["studentGradeId": studentGradeId,
                                                 "mark": mark])
        
        let endpoint = EndPoint<Empty>(url: url,
                                                   method: .get)
        
        let publisher: AnyPublisher<Void, Error> = dataTransport.makeRequest(endpoint)
            .map { model in
                return Void()
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

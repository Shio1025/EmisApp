//
//  UpdateStudentPhoneNumberGateway.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

import NetworkLayer
import Combine
import Resolver

public protocol UpdateStudentPhoneNumberGateway {
    func updateStudentPhoneNumber(userId: String,
                                  phoneNumber: String) -> AnyPublisher<Void, Error>
}

public class UpdateStudentPhoneNumberGatewayImpl: UpdateStudentPhoneNumberGateway {
    
    @Injected var dataTransport: NetworkLayer
    @Injected var apiURLProvider: ApiURLProvider
    
    public func updateStudentPhoneNumber(userId: String,
                                         phoneNumber: String) -> AnyPublisher<Void, Error> {
        
        let url = apiURLProvider.getURL(path: "/emis/api/student/update/phoneNumber",
                                        params: ["id": userId,
                                                 "phoneNumber": phoneNumber])
        
        let endpoint = EndPoint<Empty>(url: url,
                                       method: .put)
        
        let publisher: AnyPublisher<Void, Error> = dataTransport.makeRequest(endpoint)
            .map { model in
                return Void()
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

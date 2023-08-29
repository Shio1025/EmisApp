//
//  StudentFinancialUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

import Combine
import Resolver

public protocol StudentFinancialUseCase {
    func getStudentFinancialInfo(userId: String) -> AnyPublisher<StudentFinancials, Error>
}

public class StudentFinancialUseCaseImpl: StudentFinancialUseCase {
    
    @Injected var studentFinancialInfoGateway: StudentFinancialGateway
    
    public func getStudentFinancialInfo(userId: String) -> AnyPublisher<StudentFinancials, Error> {
        studentFinancialInfoGateway.getStudentFinancialInfo(userId: userId)
    }
}

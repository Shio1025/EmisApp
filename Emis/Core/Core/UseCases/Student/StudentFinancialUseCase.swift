//
//  StudentFinancialUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

import Combine
import Resolver

public protocol StudentFinancialUseCase {
    func getStudentFinancialInfo(userId: String) -> AnyPublisher<StudentInfo, Error>
}

public class StudentFinancialUseCaseImpl: StudentFinancialUseCase {
    
    @Injected var studentFinancialInfoGateway: StudentInfoGateway
    
    public func getStudentFinancialInfo(userId: String) -> AnyPublisher<StudentInfo, Error> {
        studentFinancialInfoGateway.getStudentInfo(userId: userId)
    }
}

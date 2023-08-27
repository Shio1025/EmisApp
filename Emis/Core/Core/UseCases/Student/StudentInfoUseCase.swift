//
//  StudentInfoUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

import Combine
import Resolver

public protocol StudentInfoUseCase {
    func getStudentInfo(userId: String) -> AnyPublisher<StudentInfo, Error>
}

public class StudentInfoUseCaseImpl: StudentInfoUseCase {
    
    @Injected var studentInfoGateway: StudentInfoGateway
    
    public func getStudentInfo(userId: String) -> AnyPublisher<StudentInfo, Error> {
        studentInfoGateway.getStudentInfo(userId: userId)
    }
}

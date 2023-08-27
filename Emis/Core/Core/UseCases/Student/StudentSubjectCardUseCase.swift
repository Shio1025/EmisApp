//
//  StudentSubjectCardUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

import Combine
import Resolver

public protocol StudentSubjectCardUseCase {
    func getStudentSubjectCardInfo(userId: String) -> AnyPublisher<StudentSubjectCard, Error>
}

public class StudentSubjectCardUseCaseImpl: StudentSubjectCardUseCase {
    
    @Injected var studentSubjectCardGateway: StudentSubjectCardGateway
    
    public func getStudentSubjectCardInfo(userId: String) -> AnyPublisher<StudentSubjectCard, Error> {
        studentSubjectCardGateway.getStudentSubjectCardInfo(userId: userId)
    }
}

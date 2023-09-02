//
//  TeacherSubjectCardUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 02.09.23.
//

import Combine
import Resolver

public protocol TeacherSubjectCardUseCase {
    func getTeacherSubjectCardInfo(userId: String) -> AnyPublisher<TeacherSubjectCard, Error>
}

public class TeacherSubjectCardUseCaseImpl: TeacherSubjectCardUseCase {
    
    @Injected var teacherSubjectCardGateway: TeacherSubjectCardGateway
    
    public func getTeacherSubjectCardInfo(userId: String) -> AnyPublisher<TeacherSubjectCard, Error> {
        teacherSubjectCardGateway.getTeacherSubjectCardInfo(userId: userId)
    }
}

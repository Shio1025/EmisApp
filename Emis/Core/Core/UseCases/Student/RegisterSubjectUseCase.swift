//
//  RegisterSubjectUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

import Combine
import Resolver

public protocol RegisterSubjectUseCase {
    func registerSubject(studentId: String,
                         courseId: String) -> AnyPublisher<Void, Error>
}

public class RegisterSubjectUseCaseImpl: RegisterSubjectUseCase {
    
    @Injected var registerSubjectUseCase: RegisterSubjectGateway
    
    public func registerSubject(studentId: String,
                                courseId: String) -> AnyPublisher<Void, Error> {
        registerSubjectUseCase.registerSubject(studentId: studentId,
                                               courseId: courseId)
    }
}

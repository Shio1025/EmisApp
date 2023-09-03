//
//  DeleteRegisteredSubjectUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

import Combine
import Resolver

public protocol DeleteRegisteredSubjectUseCase {
    func deleteSubject(studentId: String,
                       courseId: String) -> AnyPublisher<Void, Error>
}

public class DeleteRegisteredSubjectUseCaseImpl: DeleteRegisteredSubjectUseCase {
    
    @Injected var deleteRegisteredSubjectUseCase: DeleteRegisteredSubjectGateway
    
    public func deleteSubject(studentId: String,
                              courseId: String) -> AnyPublisher<Void, Error> {
        deleteRegisteredSubjectUseCase.deleteSubject(studentId: studentId,
                                                     courseId: courseId)
    }
}

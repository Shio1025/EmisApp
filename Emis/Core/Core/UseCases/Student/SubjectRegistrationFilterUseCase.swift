//
//  SubjectRegistrationFilterUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

import Combine
import Resolver

public protocol SubjectRegistrationFilterUseCase {
    func getSubjects(studentId: String,
                     subjectName: String,
                     page: Int,
                     size: Int) -> AnyPublisher<SubjectRegistrationFilter, Error>
}

public class SubjectRegistrationFilterUseCaseImpl: SubjectRegistrationFilterUseCase {
    
    @Injected var subjectRegistrationFilterGateway: SubjectRegistrationFilterGateway
    
    public func getSubjects(studentId: String,
                            subjectName: String,
                            page: Int,
                            size: Int) -> AnyPublisher<SubjectRegistrationFilter, Error> {
        subjectRegistrationFilterGateway.getSubjects(studentId: studentId,
                                                     subjectName: subjectName,
                                                     page: page,
                                                     size: size)
    }
}

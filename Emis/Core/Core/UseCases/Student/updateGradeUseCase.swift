//
//  updateGradeUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 02.09.23.
//

import Combine
import Resolver

public protocol updateGradeUseCase {
    func updateGrade(studentGradeId: String,
                            mark: String) -> AnyPublisher<Void, Error>
}

public class updateGradeUseCaseImpl: updateGradeUseCase {
    
    @Injected var updateMarkGateway: UpdateMarkGateway
    
    public func updateGrade(studentGradeId: String,
                            mark: String) -> AnyPublisher<Void, Error> {
        updateMarkGateway.updateGrade(studentGradeId: studentGradeId,
                                      mark: mark)
    }
}

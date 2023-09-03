//
//  GetRegisteredSubjectsUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

import Combine
import Resolver

public protocol GetRegisteredSubjectsUseCase {
    func getSubjects(studentId: String) -> AnyPublisher<[RegisteredSubject], Error>
}

public class GetRegisteredSubjectsUseCaseImpl: GetRegisteredSubjectsUseCase {
    
    @Injected var getRegisteredSubjectsGateway: GetRegisteredSubjectsGateway
    
    public func getSubjects(studentId: String) -> AnyPublisher<[RegisteredSubject], Error> {
        getRegisteredSubjectsGateway.getSubjects(studentId: studentId)
    }
}

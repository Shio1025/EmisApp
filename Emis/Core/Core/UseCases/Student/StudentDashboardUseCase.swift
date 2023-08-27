//
//  StudentDashboardUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

import Combine
import Resolver

public protocol StudentDashboardUseCase {
    func getStudentDashboardOptionsInfo(userId: String) -> AnyPublisher<StudentDashboardOptions, Error>
}

public class StudentDashboardUseCaseImpl: StudentDashboardUseCase {
    
    @Injected var studentDashboardGateway: StudentDashboardOptionsGateway
    
    public func getStudentDashboardOptionsInfo(userId: String) -> AnyPublisher<StudentDashboardOptions, Error> {
        studentDashboardGateway.getStudentDashboardOptionsInfo(userId: userId)
    }
}

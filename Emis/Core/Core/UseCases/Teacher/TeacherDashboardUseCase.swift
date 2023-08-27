//
//  TeacherDashboardUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

import Combine
import Resolver

public protocol TeacherDashboardUseCase {
    func getTeacherDashboardOptionsInfo(userId: String) -> AnyPublisher<TeacherDashboardOptions, Error>
}

public class TeacherDashboardUseCaseImpl: TeacherDashboardUseCase {
    
    @Injected var teacherDashboardOptionsGateway: TeacherDashboardOptionsGateway
    
    public func getTeacherDashboardOptionsInfo(userId: String) -> AnyPublisher<TeacherDashboardOptions, Error> {
        teacherDashboardOptionsGateway.getTeacherDashboardOptionsInfo(userId: userId)
    }
}

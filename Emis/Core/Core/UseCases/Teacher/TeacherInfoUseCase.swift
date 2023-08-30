//
//  TeacherInfoUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 30.08.23.
//

import Combine
import Resolver

public protocol TeacherInfoUseCase {
    func getTeacherInfo(userId: String) -> AnyPublisher<TeacherInfo, Error>
}

public class TeacherInfoUseCaseImpl: TeacherInfoUseCase {
    
    @Injected var teacherInfoGateway: TeacherInfoGateway
    
    public func getTeacherInfo(userId: String) -> AnyPublisher<TeacherInfo, Error> {
        teacherInfoGateway.getTeacherInfo(userId: userId)
    }
}

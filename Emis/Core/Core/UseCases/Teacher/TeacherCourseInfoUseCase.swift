//
//  TeacherCourseInfoUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 02.09.23.
//

import Combine
import Resolver

public protocol TeacherCourseInfoUseCase {
    func getTeacherCourseInfo(courseId: String) -> AnyPublisher<TeacherCourseInfo, Error>
}

public class TeacherCourseInfoUseCaseImpl: TeacherCourseInfoUseCase {
    
    @Injected var teacherCourseInfoGateway: TeacherCourseInfoGateway
    
    public func getTeacherCourseInfo(courseId: String) -> AnyPublisher<TeacherCourseInfo, Error> {
        teacherCourseInfoGateway.getTeacherCourseInfo(courseId: courseId)
    }
}

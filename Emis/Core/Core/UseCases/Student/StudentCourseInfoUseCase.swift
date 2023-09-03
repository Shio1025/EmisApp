//
//  StudentCourseInfoUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 03.09.23.
//

import Combine
import Resolver

public protocol StudentCourseInfoUseCase {
    func getStudentCourseInfo(courseId: String,
                              studentId: String) -> AnyPublisher<StudentCourseInfo, Error>
}

public class StudentCourseInfoUseCaseImpl: StudentCourseInfoUseCase {
    
    @Injected var studentCourseInfoGateway: StudentCourseInfoGateway
    
    public func getStudentCourseInfo(courseId: String,
                                     studentId: String) -> AnyPublisher<StudentCourseInfo, Error> {
        studentCourseInfoGateway.getStudentCourseInfo(courseId: courseId,
                                                      studentId: studentId)
    }
}

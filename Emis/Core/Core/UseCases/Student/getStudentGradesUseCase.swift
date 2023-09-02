//
//  getStudentGradesUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 02.09.23.
//

import Combine
import Resolver

public protocol getStudentGradesUseCase {
    func getStudentGrades(courseId: String,
                          studentId: String) -> AnyPublisher<[StudentGrade], Error>
}

public class getStudentGradesUseCaseImpl: getStudentGradesUseCase {
    
    @Injected var getStudentGradesGateway: getStudentGradesGateway
    
    public func getStudentGrades(courseId: String,
                                 studentId: String) -> AnyPublisher<[StudentGrade], Error> {
        getStudentGradesGateway.getStudentGrades(courseId: courseId,
                                                 studentId: courseId)
    }
}

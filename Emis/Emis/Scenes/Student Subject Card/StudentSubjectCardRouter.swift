//
//  StudentSubjectCardRouter.swift
//  Emis
//
//  Created by Shio Birbichadze on 03.09.23.
//

final class StudentSubjectCardRouter {
    
    func route(to route: StudentSubjectCardRoute,
               from view: StudentSubjectCardController) {
        switch route {
        case .courseInfo(let courseId, let studentId, let name):
            view.navigationController?
                .pushViewController(StudentCourseDetailsController(viewModel: .init(courseId: courseId,
                                                                                    studentId: studentId,
                                                                                    name: name)),
                                    animated: true)
        }
    }
}

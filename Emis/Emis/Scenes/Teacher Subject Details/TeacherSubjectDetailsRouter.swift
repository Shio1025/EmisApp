//
//  TeacherSubjectDetailsRouter.swift
//  Emis
//
//  Created by Shio Birbichadze on 02.09.23.
//

final class TeacherSubjectDetailsRouter {
    
    func route(to route: TeacherSubjectDetailsRoute,
               from view: TeacherSubjectDetailsController) {
        switch route {
        case .studentGrades(let courseId,
                            let studentId,
                            let studentNameAndSurname):
            view.navigationController?
                .pushViewController(StudentGradesEditorController(viewModel: .init(courseId: courseId,
                                                                                   studentId: studentId,
                                                                                   studentNameAndSurname: studentNameAndSurname)),
                                    animated: true)
        }
    }
}

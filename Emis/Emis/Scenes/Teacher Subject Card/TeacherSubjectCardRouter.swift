//
//  TeacherSubjectCardRouter.swift
//  Emis
//
//  Created by Shio Birbichadze on 02.09.23.
//

final class TeacherSubjectCardRouter {
    
    func route(to route: TeacherSubjectCardRoute,
               from view: TeacherSubjectCardController) {
        switch route {
        case .courseInfo(let courseId, let name):
            view.navigationController?
                .pushViewController(TeacherSubjectDetailsController(viewModel: .init(courseId: courseId,
                                                                                     name: name)),
                                    animated: true)
        }
    }
}

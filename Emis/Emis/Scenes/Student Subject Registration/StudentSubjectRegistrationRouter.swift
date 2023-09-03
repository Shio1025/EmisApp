//
//  StudentSubjectRegistrationRouter.swift
//  Emis
//
//  Created by Shio Birbichadze on 03.09.23.
//

final class StudentSubjectRegistrationRouter {
    
    func route(to route: StudentSubjectRegistrationRoute,
               from view: StudentSubjectRegistrationController) {
        switch route {
        case .registration:
            view.navigationController?
                .pushViewController(SubjectRegistrationController(),
                                    animated: true)
        case .registeredSubjects:
            break
        }
    }
}

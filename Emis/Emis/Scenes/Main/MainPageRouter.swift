//
//  MainPageRouter.swift
//  Emis
//
//  Created by Shio Birbichadze on 29.08.23.
//

final class MainPageRouter {
    
    func route(to route: MainPageRoute,
               from view: MainPageController) {
        switch route {
        case .studentSubjectCard:
            view.navigationController?.pushViewController(StudentSubjectCardController(), animated: true)
        case .teacherSubjectCard:
            view.navigationController?.pushViewController(TeacherSubjectCardController(), animated: true)
        case .studentSubjectRegistration:
            view.navigationController?.pushViewController(StudentSubjectRegistrationController(), animated: true)
        case .teacherSubjectsHistory:
            break
        case .library:
            view.navigationController?.pushViewController(LibraryPageController(), animated: true)
        }
    }
}

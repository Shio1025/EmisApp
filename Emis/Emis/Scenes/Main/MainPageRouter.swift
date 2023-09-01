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
            break
        case .teacherSubjectCard:
            break
        case .studentSubjectRegistration:
            break
        case .teacherSubjectsHistory:
            break
        case .library:
            view.navigationController?.pushViewController(LibraryPageController(), animated: true)
        }
    }
}

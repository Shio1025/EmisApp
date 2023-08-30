//
//  ProfilePageRouter.swift
//  Emis
//
//  Created by Shio Birbichadze on 17.06.23.
//


final class ProfilePageRouter {
    
    func route(to route: ProfilePageRoute,
               from view: ProfilePageController) {
        switch route {
        case .finances:
            view.navigationController?.pushViewController(StudentFinancesInfoController(), animated: true)
        }
    }
}

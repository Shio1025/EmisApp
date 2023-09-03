//
//  TabBarItem.swift
//  Emis
//
//  Created by Shio Birbichadze on 04.05.23.
//
import BrandBook
import UIKit

enum TabBarItem {
    case login
    case main
    case more
    
    
    var text: String {
        switch self {
        case .login:
            return "პროფილი"
        case .main:
            return "მთავარი"
        case .more:
            return "მეტი"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .login:
            return BrandBookManager.Icon.student.template
        case .main:
            return BrandBookManager.Icon.main_idea.template
        case .more:
            return BrandBookManager.Icon.settings.template
        }
    }
    
    var controller: UIViewController {
        switch self {
        case .login:
            return LoginPageController()
        case .main:
            return MainPageController()
        case .more:
            return MoreMenuController(viewModel: MoreMenuViewModel())
        }
    }
}

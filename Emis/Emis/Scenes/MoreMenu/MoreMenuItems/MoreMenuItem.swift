//
//  MoreMenuItem.swift
//  Emis
//
//  Created by Shio Birbichadze on 29.08.23.
//

import UIKit
import BrandBook

enum MoreMenuItem {
    case changePassword
    case easyAuthorization
    case GPACalculator
    case changeTheme
    case logOut
    
    
    var title: String {
        switch self {
        case .changePassword:
            return "პაროლის შეცვლა"
        case .easyAuthorization:
            return "მარტივი შესვლა"
        case .GPACalculator:
            return "GPA კალკულატორი"
        case .changeTheme:
            return "თემის შეცვლა"
        case .logOut:
            return "გასვლა"
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .logOut:
            return BrandBookManager.Color.General.red.uiColor
        default:
            return BrandBookManager.Color.General.black.uiColor
        }
    }
}

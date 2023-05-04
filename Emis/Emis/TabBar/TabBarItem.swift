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
    case profile
    case main
    case timetable
    case more
    
    
    var text: String {
        switch self {
        case .profile, .login:
            return "პროფილი"
        case .main:
            return "მთავარი"
        case .timetable:
            return "ცხრილები"
        case .more:
            return "მეტი"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .profile, .login:
            return BrandBookManager.Icon.student.template
        case .main:
            return BrandBookManager.Icon.main_idea.template
        case .timetable:
            return BrandBookManager.Icon.calendar.template
        case .more:
            return BrandBookManager.Icon.settings.template
        }
    }
    
    var controller: UIViewController {
        switch self {
        case .login:
            return LoginPage()
        case .profile:
            return LoginPage()
        case .main:
            return MainPage()
        case .timetable:
            return TimeTablePage()
        case .more:
            return MoreMenu()
        }
    }
}

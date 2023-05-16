//
//  TextFieldState.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 15.05.23.
//
import UIKit

enum textFieldState {
    case inactive
    case inProgressOfEditing
    
    var placeholderColor: UIColor {
        switch self {
        case .inactive:
            return BrandBookManager.Color.Theme.Invert.tr100.uiColor
        case .inProgressOfEditing:
            return .clear
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .inactive:
            return  BrandBookManager.Color.Theme.Invert.tr200.uiColor
        case .inProgressOfEditing:
            return BrandBookManager.Color.Theme.Component.tr300.uiColor
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .inactive:
            return BrandBookManager.Color.Theme.Background.canvas.uiColor
        case .inProgressOfEditing:
            return BrandBookManager.Color.Theme.Component.tr100.uiColor
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .inactive:
            return  BrandBookManager.Color.General.black.uiColor
        case .inProgressOfEditing:
            return BrandBookManager.Color.Theme.Component.solid500.uiColor
        }
    }
}

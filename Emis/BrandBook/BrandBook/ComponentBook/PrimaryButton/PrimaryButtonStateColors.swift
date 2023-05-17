//
//  PrimaryButtonStateColors.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 17.05.23.
//

import UIKit

enum PrimaryButtonState {
    case enabled
    case disabled
    case loading
    
    var backgroundColor: UIColor {
        switch self {
        case .enabled:
            return BrandBookManager.Color.Theme.Component.solid500.uiColor
        case .disabled:
            return BrandBookManager.Color.Theme.Component.tr100.uiColor
        case .loading:
            return BrandBookManager.Color.Theme.Component.tr300.uiColor
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .enabled:
            return BrandBookManager.Color.General.white.uiColor
        case .disabled:
            return BrandBookManager.Color.Theme.Invert.tr100.uiColor
        case .loading:
            return BrandBookManager.Color.General.white.uiColor
        }
    }
}

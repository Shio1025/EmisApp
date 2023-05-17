//
//  EmisMainManager.swift
//  Emis
//
//  Created by Shio Birbichadze on 11.04.23.
//

import UIKit
import IQKeyboardManagerSwift

protocol EmisManager {
    
}

public final class EmisMainManager: EmisManager {
    
    public static func configureIQKeyBoardManager() {
        IQKeyboardManager.shared.enable = true
    }
}

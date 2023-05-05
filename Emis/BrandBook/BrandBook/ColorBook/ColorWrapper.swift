//
//  ColorWrapper.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 11.04.23.
//

import UIKit

public struct ColorWrapper {
    private let name: String
    
    public init(name: String) {
        self.name = name
    }
    
    public var uiColor: UIColor {
        return UIColor(named: name,
                       in: Bundle(identifier: "Shio.BrandBook"),
                       compatibleWith: nil)!
    }
    
    public var cgColor: CGColor {
        return uiColor.cgColor
    }
}

//
//  ColorWrapper.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 11.04.23.
//

import UIKit

protocol ResourceWrappable {
    var designSystemName: String { get }
    static var bundle: Bundle? { get }
}

public struct ColorWrapper: ResourceWrappable {
    private let name: String
    
    public init(name: String) { self.name = name}
    
    var designSystemName: String {
        return self.name
    }
    
    static var bundle: Bundle? = Bundle(identifier: "Shio.BrandBook")
    
    
    public var uiColor: UIColor {
        return UIColor(named: designSystemName,
                       in: Self.bundle,
                       compatibleWith: nil)!
    }
    
    
    public var cgColor: CGColor {
        return uiColor.cgColor
    }
}

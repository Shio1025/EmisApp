//
//  Brandbook.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 11.04.23.
//

public protocol BrandBook {
    //Color Theme Handling
    static var currentTheme: UserTheme { get }
    static func setTheme(_ theme: UserTheme)
    
}

public struct BrandBookManager: BrandBook {
    static private var theme: UserTheme = .standard
    
    public static func setTheme(_ theme: UserTheme) {
        self.theme = theme
    }
    
    public static var currentTheme: UserTheme {
        return self.theme
    }
}

//
//  Color.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 11.04.23.
//

extension BrandBookManager {
    public struct Color {
        public struct Theme {
            public struct Background {
                public static let layer = ColorWrapper(name: "\(currentTheme)-color-background-layer")
            }
            
            public struct Component {
                public static let solid500 = ColorWrapper(name: "\(currentTheme)-color-component-solid500")
            }
        }
    }
}

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
                public static let canvas = ColorWrapper(name: "\(currentTheme)-color-background-canvas")
            }
            
            public struct Component {
                public static let solid500 = ColorWrapper(name: "\(currentTheme)-color-component-solid500")
            }
        }
        
        public struct General {
            public static let red = ColorWrapper(name: "red")
            public static let black = ColorWrapper(name: "black")
            public static let white = ColorWrapper(name: "white")
            public static let tin = ColorWrapper(name: "tin")
            public static let green = ColorWrapper(name: "green")
        }
    }
}

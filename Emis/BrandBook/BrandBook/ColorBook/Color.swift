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
                public static let popup = ColorWrapper(name: "\(currentTheme)-color-background-popup")
            }
            
            public struct Component {
                public static let solid500 = ColorWrapper(name: "\(currentTheme)-color-component-solid500")
                public static let tr100 = ColorWrapper(name: "\(currentTheme)-color-component-100")
                public static let tr200 = ColorWrapper(name: "\(currentTheme)-color-component-200")
                public static let tr300 = ColorWrapper(name: "\(currentTheme)-color-component-300")
            }
            
            public struct Invert {
                public static let tr100 = ColorWrapper(name: "\(currentTheme)-color-invert-100")
                public static let tr200 = ColorWrapper(name: "\(currentTheme)-color-invert-200")
                public static let tr300 = ColorWrapper(name: "\(currentTheme)-color-invert-300")
                public static let tr400 = ColorWrapper(name: "\(currentTheme)-color-invert-400")
                public static let tr500 = ColorWrapper(name: "\(currentTheme)-color-invert-500")
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

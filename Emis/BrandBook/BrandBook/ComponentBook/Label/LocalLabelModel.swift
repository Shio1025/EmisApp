//
//  LocalLabelModel.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 16.05.23.
//
import UIKit

public struct LocalLabelModel {
    public var text: String
    public var color: UIColor
    public var font: UIFont
    public var action: (() -> Void)?
    
    public init(text: String,
                color: UIColor,
                font: UIFont,
                action: (() -> Void)? = nil) {
        self.text = text
        self.color = color
        self.font = font
        self.action = action
    }
}

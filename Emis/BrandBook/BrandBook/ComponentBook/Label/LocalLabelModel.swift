//
//  LocalLabelModel.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 16.05.23.
//
import UIKit

public struct LocalLabelModel {
    let text: String
    let color: UIColor
    let font: UIFont
    let action: (() -> Void)?
    
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

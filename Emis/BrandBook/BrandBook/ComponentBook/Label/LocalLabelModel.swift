//
//  LocalLabelModel.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 16.05.23.
//
import UIKit
import Combine

public class LocalLabelModel: ObservableObject {
    var text: AnyPublisher<String,Never>
    var color: UIColor
    var font: UIFont
    var action: (() -> Void)?
    
    public init(text: AnyPublisher<String,Never>,
                color: UIColor,
                font: UIFont,
                action: (() -> Void)? = nil) {
        self.text = text
        self.color = color
        self.font = font
        self.action = action
    }
}

//
//  LocalLabelModel.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 16.05.23.
//
import UIKit
import Combine

public class LocalLabelModel: ObservableObject {
    var textPublisher: AnyPublisher<String,Never>?
    var text: String?
    var color: UIColor
    var font: UIFont
    var action: (() -> Void)?
    
    public init(textPublisher: AnyPublisher<String,Never>? = nil,
                text: String? = nil,
                color: UIColor = BrandBookManager.Color.General.black.uiColor,
                font: UIFont = .italicSystemFont(ofSize: .M),
                action: (() -> Void)? = nil) {
        self.textPublisher = textPublisher
        self.text =  text
        self.color = color
        self.font = font
        self.action = action
    }
}

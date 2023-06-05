//
//  PrimaryButtonModel.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 17.05.23.
//
import Combine

public struct PrimaryButtonModel {
    let titleModel: LocalLabelModel
    var state: AnyPublisher<ButtonState, Never>
    let action: (() -> Void)
    
    public init(titleModel: LocalLabelModel,
                state: AnyPublisher<ButtonState, Never>,
                action: @escaping (() -> Void)) {
        self.titleModel = titleModel
        self.state = state
        self.action = action
    }
}

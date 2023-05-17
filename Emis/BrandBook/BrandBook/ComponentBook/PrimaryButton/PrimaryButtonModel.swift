//
//  PrimaryButtonModel.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 17.05.23.
//

public struct PrimaryButtonModel {
    let titleModel: LocalLabelModel
    let action: (() -> Void)
    
    public init(titleModel: LocalLabelModel,
                action: @escaping (() -> Void)) {
        self.titleModel = titleModel
        self.action = action
    }
}

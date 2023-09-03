//
//  TextFieldViewModel.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 11.05.23.
//

import UIKit

public class TextFieldViewModel: ObservableObject {
    let placeholder: String?
    let trailingLabelModel: LocalLabelModel?
    let leadingLabelModel: LocalLabelModel?
    let onEditingDidEnd: ((String) -> Void)
    let isSecureEntry: Bool
    let keyboardType: UIKeyboardType?
    let currText: String?
    
    public init(placeholder: String? = nil,
                trailingLabelModel: LocalLabelModel? = nil,
                leadingLabelModel: LocalLabelModel? = nil,
                isSecureEntry: Bool = false,
                keyboardType: UIKeyboardType? = nil,
                currText: String? = nil,
                onEditingDidEnd: @escaping ((String) -> Void)) {
        self.placeholder = placeholder
        self.leadingLabelModel = leadingLabelModel
        self.trailingLabelModel = trailingLabelModel
        self.isSecureEntry = isSecureEntry
        self.keyboardType = keyboardType
        self.onEditingDidEnd = onEditingDidEnd
        self.currText = currText
    }
}



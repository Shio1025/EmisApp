//
//  TextFieldViewModel.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 11.05.23.
//

public struct TextFieldViewModel {
    let placeholder: String?
    let detail: String?
    let trailingLabelModel: LocalLabelModel?
    let leadingLabelModel: LocalLabelModel?
    let onEditingDidEnd: ((String) -> Void)
    
    public init(placeholder: String? = nil,
                detail: String? = nil,
                trailingLabelModel: LocalLabelModel? = nil,
                leadingLabelModel: LocalLabelModel? = nil,
                onEditingDidEnd: @escaping ((String) -> Void)) {
        self.placeholder = placeholder
        self.detail = detail
        self.leadingLabelModel = leadingLabelModel
        self.trailingLabelModel = trailingLabelModel
        self.onEditingDidEnd = onEditingDidEnd
    }
}



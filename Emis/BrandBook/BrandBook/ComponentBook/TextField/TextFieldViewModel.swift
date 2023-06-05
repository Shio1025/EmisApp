//
//  TextFieldViewModel.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 11.05.23.
//

public class TextFieldViewModel: ObservableObject {
    let placeholder: String?
    let trailingLabelModel: LocalLabelModel?
    let leadingLabelModel: LocalLabelModel?
    let onEditingDidEnd: ((String) -> Void)
    
    public init(placeholder: String? = nil,
                trailingLabelModel: LocalLabelModel? = nil,
                leadingLabelModel: LocalLabelModel? = nil,
                onEditingDidEnd: @escaping ((String) -> Void)) {
        self.placeholder = placeholder
        self.leadingLabelModel = leadingLabelModel
        self.trailingLabelModel = trailingLabelModel
        self.onEditingDidEnd = onEditingDidEnd
    }
}



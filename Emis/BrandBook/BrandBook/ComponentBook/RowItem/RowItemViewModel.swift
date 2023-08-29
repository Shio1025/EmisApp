//
//  RowItemViewModel.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 19.06.23.
//


public class RowItemViewModel {
    
    var leftItem: ResourceType?
    var labels: Labels?
    var rightItem: Item?
    var tapAction: (() -> Void)?
    var isSeparatorNeeded: Bool
    
    public init(leftItem: ResourceType? = nil,
                labels: Labels? = nil,
                rightItem: Item? = nil,
                tapAction: (() -> Void)? = nil,
                isSeparatorNeeded: Bool = false) {
        self.leftItem = leftItem
        self.labels = labels
        self.rightItem = rightItem
        self.tapAction = tapAction
        self.isSeparatorNeeded = isSeparatorNeeded
    }
}

public enum Labels {
    case one(model: LocalLabelModel)
    case two(top: LocalLabelModel, bottom: LocalLabelModel)
}

public enum Item {
    case label(model: LocalLabelModel)
    case button(model: SmallButtonViewModel)
    case labelAndButton(labelModel: LocalLabelModel, buttonModel: SmallButtonViewModel)
}

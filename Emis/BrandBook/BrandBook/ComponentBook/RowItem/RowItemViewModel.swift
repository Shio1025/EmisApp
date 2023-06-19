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
    
    public init(leftItem: ResourceType? = nil,
         labels: Labels? = nil,
         rightItem: Item? = nil) {
        self.leftItem = leftItem
        self.labels = labels
        self.rightItem = rightItem
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

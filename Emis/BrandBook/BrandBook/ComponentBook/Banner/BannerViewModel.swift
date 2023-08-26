//
//  BannerViewModel.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 25.08.23.
//

public class BannerViewModel {
    
    var resourceType: ResourceType
    var topLabelModel: LocalLabelModel
    var bottomLabelModel: LocalLabelModel?
    var isChevronNeeded: Bool
    var action: () -> Void
    
    public init(resourceType: ResourceType,
                topLabelModel: LocalLabelModel,
                bottomLabelModel: LocalLabelModel? = nil,
                isChevronNeeded: Bool = false,
                action: @escaping () -> Void) {
        self.resourceType = resourceType
        self.topLabelModel = topLabelModel
        self.bottomLabelModel = bottomLabelModel
        self.isChevronNeeded = isChevronNeeded
        self.action = action
    }
}

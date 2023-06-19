//
//  PageDescriptionViewModel.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 19.06.23.
//

public class PageDescriptionViewModel {
    
    var resourceType: ResourceType?
    var description: LocalLabelModel
    var header: LocalLabelModel?
    
    public init(resourceType: ResourceType? = nil,
                description: LocalLabelModel,
                header: LocalLabelModel? = nil) {
        self.resourceType = resourceType
        self.description = description
        self.header = header
    }
}

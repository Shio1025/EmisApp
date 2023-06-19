//
//  SmallButtonViewModel.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 19.06.23.
//

public class SmallButtonViewModel {
    var resourceType: ResourceType
    var action: (() -> Void)
    
    public init(resourceType: ResourceType,
                action: @escaping () -> Void) {
        self.resourceType = resourceType
        self.action = action
    }
}

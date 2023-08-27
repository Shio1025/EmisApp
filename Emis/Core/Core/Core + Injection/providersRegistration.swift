//
//  providersRegistration.swift
//  Core
//
//  Created by Shio Birbichadze on 26.08.23.
//

import Resolver

extension Resolver {
    
    public static func registerCoreProviders() {
        register(ApiURLProvider.self) { ApiUURLProviderImpl() }.scope(.application)
    }
}

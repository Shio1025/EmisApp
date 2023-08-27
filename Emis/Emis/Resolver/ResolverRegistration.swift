//
//  ResolverRegistration.swift
//  Emis
//
//  Created by Shio Birbichadze on 11.05.23.
//

import Resolver
import SSO
import Core

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerRouters()
        registerSSOInterfaces()
        registerNetworkLayer()
        registerGateways()
        registerUseCases()
        registerCoreProviders()
    }
}

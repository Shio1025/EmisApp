//
//  ResolverRegistration.swift
//  Emis
//
//  Created by Shio Birbichadze on 11.05.23.
//

import Resolver
import SSO

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerRouters()
        registerSSOInterfaces()
    }
    
    private static func registerSSOInterfaces() {
        register(SSOManager.self) { SSOManagerImpl() }.scope(.application)
    }
}

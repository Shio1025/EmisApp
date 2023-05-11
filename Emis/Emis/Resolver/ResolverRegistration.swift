//
//  ResolverRegistration.swift
//  Emis
//
//  Created by Shio Birbichadze on 11.05.23.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerRouters()
    }
}

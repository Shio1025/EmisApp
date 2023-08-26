//
//  ResolverRegistration + NetworkLayer.swift
//  Emis
//
//  Created by Shio Birbichadze on 26.08.23.
//

import Resolver
import NetworkLayer

extension Resolver {
    
    public static func registerNetworkLayer() {
        register(NetworkLayer.self) { NetworkService() }.scope(.application)
    }
}

//
//  SSO + Injection.swift
//  SSO
//
//  Created by Shio Birbichadze on 17.07.23.
//



import Resolver

extension Resolver {
    
    public static func registerSSOInterfaces() {
        register(SSOManager.self) { SSOManagerImpl() }.scope(.application)
    }
}

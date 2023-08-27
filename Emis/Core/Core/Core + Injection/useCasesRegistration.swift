//
//  useCasesRegistration.swift
//  Core
//
//  Created by Shio Birbichadze on 26.08.23.
//

import Resolver

extension Resolver {
    
    public static func registerUseCases() {
        register(LoginUseCase.self) { LoginUseCaseImpl() }
    }
}

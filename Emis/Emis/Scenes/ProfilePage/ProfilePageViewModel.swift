//
//  ProfilePageViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 17.06.23.
//

import BrandBook
import Combine
import Resolver

enum ProfilePageRoute {
    
}

final class ProfilePageViewModel {
    
    @Published private var router: ProfilePageRoute?
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() { }
    
}

extension ProfilePageViewModel {
    
    func getRouter() -> AnyPublisher<ProfilePageRoute?, Never> {
        $router.eraseToAnyPublisher()
    }
}

extension ProfilePageViewModel {
    
}




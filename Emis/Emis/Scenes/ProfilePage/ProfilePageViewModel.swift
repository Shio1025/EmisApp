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
    @Published private var listCells: [any CellModel] = []
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
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




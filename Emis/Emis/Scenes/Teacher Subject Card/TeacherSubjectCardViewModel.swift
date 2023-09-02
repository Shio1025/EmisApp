//
//  TeacherSubjectCardViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 02.09.23.
//

import BrandBook
import Combine
import Resolver
import SSO
import Core
import UIKit

enum TeacherSubjectCardRoute {
    case studentInfo
}

final class TeacherSubjectCardViewModel {
    
    @Published private var router: TeacherSubjectCardRoute?
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = false
    @Injected private var SSO: SSOManager
    
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
    var pageIsLoading: AnyPublisher<Bool, Never> {
        $isLoading.eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        loadInfo()
    }
    
    private func loadInfo() {
        isLoading = true
        
    }
}

extension TeacherSubjectCardViewModel {
    
    func getRouter() -> AnyPublisher<TeacherSubjectCardRoute?, Never> {
        $router.eraseToAnyPublisher()
    }
}

extension TeacherSubjectCardViewModel {
    
    private func getSpacerCell() -> SpacerCellModel {
        .init()
    }
}

extension TeacherSubjectCardViewModel {
    
    private func getCourses() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.draw()
            self.isLoading = false
        }
    }
}

extension TeacherSubjectCardViewModel {
    
    private func draw() {
        
    }
}

extension TeacherSubjectCardViewModel {
    
    
}



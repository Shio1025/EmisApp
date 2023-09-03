//
//  RegisteredSubjectsViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 03.09.23.
//

import BrandBook
import UIKit
import Combine
import Resolver
import SSO
import Core

final class RegisteredSubjectsViewModel {
    
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = true
    @Published private var statusBanner: StatusBannerViewModel?
    @Injected private var SSO: SSOManager
    
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
    var pageIsLoading: AnyPublisher<Bool, Never> {
        $isLoading.eraseToAnyPublisher()
    }
    
    var displayBannerPublisher: AnyPublisher<StatusBannerViewModel, Never> {
         $statusBanner
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        loadSubjects()
    }
}

extension RegisteredSubjectsViewModel {
    
    private func getRoundedHeaderWithTitle(title: String) -> RoundedHeaderWithTitleModel {
        .init(headerTitle: title)
    }
    
    private func getRoundedFooterModel() -> RoundedFooterModel {
        .init()
    }
}

extension RegisteredSubjectsViewModel {
    
    private func loadSubjects() {
        isLoading = false
        draw()
        //courseId
        //subjectName
        //subjectCode
        
    }
}

extension RegisteredSubjectsViewModel {
    
    private func draw() {
        getSubjects().map { listCells = $0 }
    }
    
    func getSubjects() -> [any CellModel]? {
        var rows: [any CellModel] = []
        
        return rows
    }
    
    private func deleteSubject() {
        
    }
}


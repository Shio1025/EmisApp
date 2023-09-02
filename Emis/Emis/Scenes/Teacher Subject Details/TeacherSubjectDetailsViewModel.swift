//
//  TeacherSubjectDetailsViewModel.swift
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

enum TeacherSubjectDetailsRoute {
    
}

final class TeacherSubjectDetailsViewModel {
    
    @Published private var router: TeacherSubjectDetailsRoute?
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = false
    @Published private var statusBanner: StatusBannerViewModel?
    @Published private var buttonState: ButtonState = .enabled
    @Injected private var SSO: SSOManager
    
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
    var pageIsLoading: AnyPublisher<Bool, Never> {
        $isLoading.eraseToAnyPublisher()
    }
    
    var state: AnyPublisher<ButtonState, Never> {
        return $buttonState
            .eraseToAnyPublisher()
    }
    
    var displayBannerPublisher: AnyPublisher<StatusBannerViewModel, Never> {
         $statusBanner
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    private let courseId: Int64
    let name: String
    
    init(courseId: Int64,
         name: String) {
        self.courseId = courseId
        self.name = name
        loadInfo()
    }
    
    private func loadInfo() {
        isLoading = true
        getCourseDetails()
    }
}

extension TeacherSubjectDetailsViewModel {
    
    func getRouter() -> AnyPublisher<TeacherSubjectDetailsRoute?, Never> {
        $router.eraseToAnyPublisher()
    }
}

extension TeacherSubjectDetailsViewModel {
    
    private func getSpacerCell() -> SpacerCellModel {
        .init()
    }
    
    private func getRoundedFooterModel() -> RoundedFooterModel {
        .init()
    }
    
    private func getRoundedHeaderModel() -> RoundedHeaderModel {
        .init()
    }
    
    private func getRoundedHeaderWithTitle(title: String) -> RoundedHeaderWithTitleModel {
        .init(headerTitle: title)
    }
}

extension TeacherSubjectDetailsViewModel {
    
    private func getCourseDetails() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.draw()
            self.isLoading = false
        }
    }
}

extension TeacherSubjectDetailsViewModel {
    
    private func draw() {
        
        var rows: [any CellModel] = []
        
        listCells = rows
    }
    
    private var button: PrimaryButtonCellModel {
        PrimaryButtonCellModel(buttonModels: .init(titleModel: .init(text: "სილაბუსის გადმოწერა  ↓"),
                                                               state: state,
                                                               action: {
            
        }))
    }
}

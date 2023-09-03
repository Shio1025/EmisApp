//
//  StudentSubjectRegistrationViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 03.09.23.
//

import BrandBook
import Combine
import Resolver
import SSO
import Core
import UIKit

enum StudentSubjectRegistrationRoute {
    case registration
    case registeredSubjects
}

final class StudentSubjectRegistrationViewModel {
    
    @Published private var router: StudentSubjectRegistrationRoute?
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = false
    @Published private var teacherSubjectCardInfo: [TeacherSubjectCard]?
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
        loadInfo()
    }
    
    private func loadInfo() {
        isLoading = true
        getItems()
    }
}

extension StudentSubjectRegistrationViewModel {
    
    func getRouter() -> AnyPublisher<StudentSubjectRegistrationRoute?, Never> {
        $router.eraseToAnyPublisher()
    }
}

extension StudentSubjectRegistrationViewModel {
    
    private func getSpacerCell() -> SpacerCellModel {
        .init()
    }
    
    private func getRoundedFooterModel() -> RoundedFooterModel {
        .init()
    }
    
    private func getRoundedHeaderModel() -> RoundedHeaderModel {
        .init()
    }
}

extension StudentSubjectRegistrationViewModel {
    
    private func getItems() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.draw()
            self.isLoading = false
        }
    }
}

extension StudentSubjectRegistrationViewModel {
    
    private func draw() {
        
        var rows: [any CellModel] = []
        
        rows.append(getSpacerCell())
        
        rows.append(getRoundedHeaderModel())
        rows.append(RowItemCellModel(model:
                .init(labels: .one(model:
                        .init(text: "რეგისტრაცია",
                              font: .systemFont(ofSize: .XL,
                                                weight: .light))),
                      rightItem: .button(model:
                            .init(resourceType: .icon(icon: UIImage(systemName: "chevron.right")!,
                                                      tintColor: BrandBookManager.Color.Theme.Invert.tr500.uiColor.withAlphaComponent(0.9)),
                                  action: { [weak self] in
            self?.router = .registration
        })),
                      tapAction: { [weak self] in
            self?.router = .registration
        })))
        rows.append(getRoundedFooterModel())
        rows.append(getSpacerCell())
        
        
        rows.append(getRoundedHeaderModel())
        rows.append(RowItemCellModel(model:
                .init(labels: .one(model:
                        .init(text: "დარეგისტრირებული საგნები",
                              font: .systemFont(ofSize: .XL,
                                                weight: .light))),
                      rightItem: .button(model:
                            .init(resourceType: .icon(icon: UIImage(systemName: "chevron.right")!,
                                                      tintColor: BrandBookManager.Color.Theme.Invert.tr500.uiColor.withAlphaComponent(0.9)),
                                  action: { [weak self] in
            self?.router = .registeredSubjects
        })),
                      tapAction: { [weak self] in
            self?.router = .registeredSubjects
        })))
        rows.append(getRoundedFooterModel())
        rows.append(getSpacerCell())
        
        listCells = rows
    }
}

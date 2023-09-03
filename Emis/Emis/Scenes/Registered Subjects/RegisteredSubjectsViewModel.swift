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
    @Injected private var getRegisteredSubjectsUseCase: GetRegisteredSubjectsUseCase
    @Injected private var deleteRegisteredSubjectUseCase: DeleteRegisteredSubjectUseCase
    
    private var registeredSubjects: [RegisteredSubject]?
    
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
        
        
        registeredSubjects = [.init(courseId: 1, subjectCode: "12", subjectName: "biology", necessary: true),
                              .init(courseId: 1, subjectCode: "12", subjectName: "biology", necessary: false),
                              .init(courseId: 1, subjectCode: "12", subjectName: "biology", necessary: true),
                              .init(courseId: 1, subjectCode: "12", subjectName: "biology", necessary: true),
                              .init(courseId: 1, subjectCode: "12", subjectName: "biology", necessary: false),
                              .init(courseId: 1, subjectCode: "12", subjectName: "biology", necessary: true),
                              .init(courseId: 1, subjectCode: "12", subjectName: "biology", necessary: false)]
        draw()
//        isLoading = true
//        getRegisteredSubjectsUseCase.getSubjects(studentId: SSO.userInfo?.userId?.description ?? "")
//            .sink { [weak self] completion in
//                self?.isLoading = false
//                switch completion {
//                case .finished:
//                    self?.draw()
//                case .failure(_):
//                    self?.statusBanner = .init(bannerType: .failure,
//                                               description: "ბოდიშს გიხდით შეფერხებისთის")
//                }
//            } receiveValue: { [weak self] model in
//                self?.registeredSubjects = model
//            }.store(in: &subscriptions)
    }
}

extension RegisteredSubjectsViewModel {
    
    private func draw() {
        getSubjects().map { listCells = $0 }
    }
    
    func getSubjects() -> [any CellModel]? {
        guard let registeredSubjects else { return nil }
        var rows: [any CellModel] = []
        
        rows.append(getRoundedHeaderWithTitle(title: "დარეგისტრირებული საგნები"))
        registeredSubjects.enumerated().forEach { index, model in
            let button: SecondaryButtonModel? = model.necessary
            ? nil
            : .init(titleModel: .init(text: "გაუქმება"),
                    action: { [weak self] in
                self?.deleteSubject(courseId: model.courseId)
            })
            
            let row = InfoCellModel(topLabelModel: .init(text: model.subjectName,
                                                         font: .systemFont(ofSize: .XL)),
                                    bottomLabelModel: .init(text: model.subjectCode,
                                                            font: .systemFont(ofSize: .L,
                                                                              weight: .light)),
                                    buttonModel: button,
                                    isSeparatorNeeded: index != (registeredSubjects.count - 1))
            
            rows.append(row)
        }
        rows.append(getRoundedFooterModel())
        
        return rows
    }
    
    private func deleteSubject(courseId: Int64) {
        isLoading = true
        deleteRegisteredSubjectUseCase.deleteSubject(studentId: SSO.userInfo?.userId?.description ?? "",
                                                     courseId: courseId.description)
        .sink { [weak self] completion in
            self?.isLoading = false
            switch completion {
            case .finished:
                self?.statusBanner = .init(bannerType: .success,
                                           description: "საგანი წარმატებით წაიშალა")
                self?.loadSubjects()
            case .failure(_):
                self?.statusBanner = .init(bannerType: .failure,
                                           description: "საგნის გაუქმება ვერ მოხერხდა")
            }
        } receiveValue: { [weak self] _ in
            
        }.store(in: &subscriptions)

    }
}


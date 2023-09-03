//
//  SubjectRegistrationViewModel.swift
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

final class SubjectRegistrationViewModel {
    
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = false
    @Published private var tableLoading: Bool = true
    @Published var pageIsLoading: Bool = false
    @Published private var totalPages: Int?
    @Published private var totalFoundSubjects: Int?
    @Published private var subjectName: String?
    @Published private var author: String?
    @Published private var statusBanner: StatusBannerViewModel?
    private var indexOfprerequisites: Int? = nil
    
    @Injected private var getFilteredSubjects: SubjectRegistrationFilterUseCase
    @Injected var urlProvider: ApiURLProvider
    @Injected var SSO: SSOManager
    
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
    var tableIsLoading: AnyPublisher<Bool, Never> {
        $tableLoading.eraseToAnyPublisher()
    }
    
    var displayBannerPublisher: AnyPublisher<StatusBannerViewModel, Never> {
         $statusBanner
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    private var validToSearch: AnyPublisher<ButtonState, Never> {
        return $isLoading
            .map { $0 ? .loading : .enabled }
            .eraseToAnyPublisher()
    }
    
    private var isEnabledTap: AnyPublisher <Bool, Never> {
        return Publishers.CombineLatest($isLoading, $tableLoading)
            .map { isLoading, tableIsLoading in
                return !(isLoading || tableIsLoading)
            }.eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    private var subjectRegistrationFilterModel: SubjectRegistrationFilter?
    
    init() { }
}

extension SubjectRegistrationViewModel {
    
    private func getSpacerCell() -> SpacerCellModel {
        .init()
    }
    
    private func getRoundedHeaderWithTitle(title: String) -> RoundedHeaderWithTitleModel {
        .init(headerTitle: title)
    }
    
    private func getRoundedFooterModel() -> RoundedFooterModel {
        .init()
    }
}

extension SubjectRegistrationViewModel {
    
    private func getSubjects(by index: Int) {
        tableLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if index == .zero {
                self.totalPages = 20
                self.totalFoundSubjects = 120
            }
            self.subjectRegistrationFilterModel = .init(content: [.init(courseId: 99,
                                                                        subjectCode: "lkm", subjectName: "lkl", available: true, prerequisites: ["sdvcsdc","dsasdx"]),
                                                                  .init(courseId: 99,
                                                                        subjectCode: "lkm", subjectName: "lkl", available: true, prerequisites: ["sdvcsdc","dsasdx"]),
                                                                  .init(courseId: 99,
                                                                        subjectCode: "lkm", subjectName: "lkl", available: false, prerequisites: ["sdvcsdc","dsasdx"]),
                                                                  .init(courseId: 99,
                                                                        subjectCode: "lkm", subjectName: "lkl", available: true, prerequisites: ["sdvcsdc","dsasdx"]),
                                                                  .init(courseId: 99,
                                                                        subjectCode: "lkm", subjectName: "lkl", available: true, prerequisites: ["sdvcsdc","dsasdx"]),
                                                                  .init(courseId: 99,
                                                                        subjectCode: "lkm", subjectName: "lkl", available: false, prerequisites: ["sdvcsdc","dsasdx"]),
                                                                  .init(courseId: 99,
                                                                        subjectCode: "lkm", subjectName: "lkl", available: true, prerequisites: ["sdvcsdc","dsasdx"])],
                                                        totalElements: 6,
                                                        totalPages: 1)
            self.draw()
            self.tableLoading = false
            self.isLoading = false
        }
        
//        tableLoading = true
//        getFilteredSubjects.getSubjects(studentId: SSO.userInfo?.userId?.description ?? "",
//                                        subjectName: subjectName ?? "",
//                                        page: index,
//                                        size: 10)
//        .sink { [weak self] completion in
//            self?.isLoading = false
//            switch completion {
//            case .finished:
//                self?.tableLoading = false
//                self?.draw()
//            case .failure(let error):
//                self?.statusBanner = .init(bannerType: .failure,
//                                           description: error.localizedDescription)
//            }
//
//        } receiveValue: { [weak self] model in
//            self?.subjectRegistrationFilterModel = model
//            if index == .zero {
//                self?.totalPages = model.totalPages
//                self?.totalFoundSubjects = model.totalElements
//            }
//        }.store(in: &subscriptions)
    }
}

extension SubjectRegistrationViewModel {
    
    private func draw() {
        guard let subjectRegistrationFilterModel else { return }
        
        var rows: [any CellModel] = subjectRegistrationFilterModel.content.enumerated().map { index, subject in
            let buttonModel: SecondaryButtonModel = subject.available
            ? .init(titleModel: .init(text: "რეგისტრაცია"), action: { [weak self] in
                self?.registerSubject(courseId: subject.courseId)
            })
            : .init(titleModel: .init(text: "?     "),
                    backgroundColor: .clear,
                    textColor: BrandBookManager.Color.Theme.Component.solid500.uiColor, action: { [weak self] in
                self?.indexOfprerequisites = index == self?.indexOfprerequisites ? nil : index
                self?.draw()
            })
            let row = InfoCellModel(topLabelModel: .init(text: subject.subjectName, font: .systemFont(ofSize: .XL)),
                                    bottomLabelModel: .init(text: subject.subjectCode,font: .systemFont(ofSize: .L,
                                                                                                        weight: .thin)),
                                    buttonModel: buttonModel,
                                    isSeparatorNeeded: index != indexOfprerequisites && index != (subjectRegistrationFilterModel.content.count - 1))
            return row
        }
        
        if let indexOfprerequisites {
            rows.insert(contentsOf: getPrerequisitesDesc(text: subjectRegistrationFilterModel.content[indexOfprerequisites].prerequisitesDesc), at: indexOfprerequisites + 1)
        }
        
        listCells = rows
    }
    
    private func getPrerequisitesDesc(text: String) -> [any CellModel] {
        var rows: [any CellModel] = []
        
        rows.append(LocalLabelCellModel(model: .init(text: "პრერეკვიზიტები: \(text)",
                                                     font: .italicSystemFont(ofSize: .L))))
        rows.append(SeparatorCellModel())
        
        return rows
    }
}

extension SubjectRegistrationViewModel {
    
    var continueButtonModel: PrimaryButtonModel {
        PrimaryButtonModel(titleModel: .init(text: "ძიება",
                                             color: BrandBookManager.Color.General.white.uiColor,
                                             font: .systemFont(ofSize: .L,
                                                               weight: .semibold)),
                           state: validToSearch,
                           action: { [weak self] in
            self?.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self?.getSubjects(by: 0)
            }
        })
    }
    
    var resultLabelModel: AnyPublisher<LocalLabelModel, Never> {
        return $totalFoundSubjects
            .compactMap {
                let text = $0 == nil ? "შენ ჯერ არ გაქვს დაწყებული ძიების პროცესი, ჩაწერე სასურველი საგნის დასახელება და დარეგისტრირდი შენთვის სასურველ საგანზე" : "მოიძებნა \($0 ?? 0) წიგნი"
                return LocalLabelModel.init(text: text,
                                            color: BrandBookManager.Color.Theme.Invert.tr300.uiColor,
                                            font: .systemFont(ofSize: .M,
                                                              weight: .light))
                
            }
            .eraseToAnyPublisher()
    }
    
    var subjectNameTextFieldModel: TextFieldViewModel {
        return TextFieldViewModel(placeholder: "საგნის არჩევა",
                                  onEditingDidEnd: { [weak self] text in
            self?.subjectName = text
        })
    }
    
    var navigatorViewModel: AnyPublisher<NavigatorViewModel, Never> {
        return $totalPages
            .map { [unowned self] totalPages in
                    .init(totalPages: totalPages,
                          isEnabledTap: self.isEnabledTap) { [weak self] index in
                        self?.getSubjects(by: index)
                    }
            }.eraseToAnyPublisher()
    }
}

extension SubjectRegistrationViewModel {
    
    private func registerSubject(courseId: Int64) {
        @Injected var registerSubjectUseCase: RegisterSubjectUseCase
        
        pageIsLoading = true
        registerSubjectUseCase.registerSubject(studentId: SSO.userInfo?.userId?.description ?? "",
                                               courseId: courseId.description)
        .sink { [weak self] completion in
            self?.pageIsLoading = false
            switch completion {
            case .finished:
                self?.statusBanner = .init(bannerType: .success,
                                           description: "საგანზე წარმატებით დარეგისტრირდი")
            case .failure:
                self?.statusBanner = .init(bannerType: .failure,
                                           description: "საგანზე ვერ დარეგისტრირდი")
            }
        } receiveValue: { _ in
            
        }.store(in: &subscriptions)
    }
}

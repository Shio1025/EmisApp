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
    @Published private var totalPages: Int?
    @Published private var totalFoundSubjects: Int?
    @Published private var subjectName: String?
    @Published private var author: String?
    @Published private var statusBanner: StatusBannerViewModel?
    @Published private var tappedBookURL : (URL,String)?
    
    @Injected private var libraryUseCase: LibraryUseCase
    @Injected var urlProvider: ApiURLProvider
    
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
    
    var pdfURL: AnyPublisher <(URL, String), Never> {
        return $tappedBookURL
            .drop(while: { elems in
                elems == nil
            })
            .map { elems in
                return (elems!.0, elems!.1)
            }.eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    private var libriryInfo: Library?
    
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
            self.draw()
            self.tableLoading = false
            self.isLoading = false
        }
//        if index == .zero { isLoading = true }
//                tableLoading = true
//        libraryUseCase.getBooks(title: name ?? "",
//                                author: author ?? "",
//                                page: index,
//                                size: 10)
//        .sink { [weak self] completion in
//            self?.isLoading = false
//            switch completion {
//            case .finished:
//                self?.tableLoading = false
//                self?.draw()
//            case .failure(let error):
//
//                self?.statusBanner = .init(bannerType: .failure,
//                                           description: error.localizedDescription)
//            }
//
//        } receiveValue: { [weak self] model in
//            self?.libriryInfo = model
//            if index == .zero {
//                self?.totalPages = model.totalPages
//                self?.totalFoundBooks = model.totalElements
//            }
//        }.store(in: &subscriptions)
    }
}

extension SubjectRegistrationViewModel {
    
    private func draw() {
//        guard let libriryInfo else { return }
        
//        let rows: [any CellModel] = libriryInfo.content.enumerated().map { index, book in
//            InfoCellModel(topLabelModel: .init(text: book.title, font: .systemFont(ofSize: .XL)),
//                          middleLabelModel: .init(text: book.author, font: .systemFont(ofSize: .L,
//                                                                                       weight: .light)),
//                          bottomLabelModel: .init(text: book.genre,font: .systemFont(ofSize: .L,
//                                                                                     weight: .thin)),
//                          buttonModel: .init(titleModel: .init(text: "რეგისტრაცია"),
//                                             action: { [weak self] in
//                guard let self else { return }
//
//                let url = self.urlProvider.getURL(path: "/emis/api/library/download",
//                                                  params: ["id": book.id.description])
//                if let url {
//                    self.tappedBookURL = (url, book.title + " - " + book.author)
//                }
//            }),
//                          isSeparatorNeeded: index != (libriryInfo.content.count - 1))
//        }
        
        listCells = []
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                self?.getBooks(by: 0)
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
//                        self?.getBooks(by: index)
                    }
            }.eraseToAnyPublisher()
    }
}


//
//  LibraryPageViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 30.08.23.
//

import BrandBook
import UIKit
import Combine
import Resolver
import SSO
import Core

final class LibraryPageViewModel {
    
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = false
    @Published private var tableLoading: Bool = true
    @Published private var totalPages: Int?
    @Published private var totalFoundBooks: Int?
    @Published private var name: String?
    @Published private var author: String?
    @Published private var statusBanner: StatusBannerViewModel?
    
    @Injected private var libraryUseCase: LibraryUseCase
    
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
    private var libriryInfo: Library?
    
    init() { }
}

extension LibraryPageViewModel {
    
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

extension LibraryPageViewModel {
    
    private func getBooks(by index: Int) {
        tableLoading = true
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.libriryInfo = .init(content: [.init(id: 1, title: "12", author: "shio", genres: ["scsd", "sdcd"]),
                                               .init(id: 1, title: "12", author: "shio", genres: ["scsd", "sdcd"]),
                                               .init(id: 1, title: "12", author: "shio", genres: ["scsd", "sdcd"]),
                                               .init(id: 1, title: "12", author: "shio", genres: ["scsd", "sdcd"]),
                                               .init(id: 1, title: "12", author: "shio", genres: ["scsd", "sdcd"]),
                                               .init(id: 1, title: "12", author: "shio", genres: ["scsd", "sdcd"]),
                                               .init(id: 1, title: "12", author: "shio", genres: ["scsd", "sdcd"]),
                                               .init(id: 1, title: "12", author: "shio", genres: ["scsd", "sdcd"]),
                                               .init(id: 1, title: "12", author: "shio", genres: ["scsd", "sdcd"]),
                                               .init(id: 1, title: "12", author: "shio", genres: ["scsd", "sdcd"])], totalElements: 120,
                                     totalPages: 20)
            if index == .zero {
                self.totalPages = 20
                self.totalFoundBooks = 120
            }
            self.draw()
            self.tableLoading = false
            self.isLoading = false
        }
//        if index == .zero { isLoading = true }
        //        tableLoading = true
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

extension LibraryPageViewModel {
    
    private func draw() {
        guard let libriryInfo else { return }
        
        let rows: [any CellModel] = libriryInfo.content.enumerated().map { index, book in
            InfoCellModel(topLabelModel: .init(text: book.title, font: .systemFont(ofSize: .XL)),
                          middleLabelModel: .init(text: book.author, font: .systemFont(ofSize: .L,
                                                                                       weight: .light)),
                          bottomLabelModel: .init(text: book.genre,font: .systemFont(ofSize: .L,
                                                                                     weight: .thin)),
                          buttonModel: .init(titleModel: .init(text: "გადმოწერა"),
                                             action: {
                
            }),
                          isSeparatorNeeded: index != (libriryInfo.content.count - 1))
        }
        
        listCells = rows
    }
}

extension LibraryPageViewModel {
    
    var continueButtonModel: PrimaryButtonModel {
        PrimaryButtonModel(titleModel: .init(text: "ძიება",
                                             color: BrandBookManager.Color.General.white.uiColor,
                                             font: .systemFont(ofSize: .L,
                                                               weight: .semibold)),
                           state: validToSearch,
                           action: { [weak self] in
            self?.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self?.getBooks(by: 0)
            }
        })
    }
    
    var resultLabelModel: AnyPublisher<LocalLabelModel, Never> {
        return $totalFoundBooks
            .compactMap {
                let text = $0 == nil ? "შენ ჯერ არ გაქვს დაწყებული ძიების პროცესი, ჩაწერე სასურველი ავტორი ან წიგნის დასახელება და მოძებნე შენთვის სასურველი წიგნი" : "მოიძებნა \($0 ?? 0) წიგნი"
                return LocalLabelModel.init(text: text,
                                            color: BrandBookManager.Color.Theme.Invert.tr300.uiColor,
                                            font: .systemFont(ofSize: .M,
                                                              weight: .light))
                
            }
            .eraseToAnyPublisher()
    }
    
    var authorTextFieldModel: TextFieldViewModel {
        return TextFieldViewModel(placeholder: "ავტორი",
                                  onEditingDidEnd: { [weak self] text in
            self?.author = text
        })
    }
    
    var bookNameTextFieldModel: TextFieldViewModel {
        return TextFieldViewModel(placeholder: "წიგნის სახელი",
                                  onEditingDidEnd: { [weak self] text in
            self?.name = text
        })
    }
    
    var navigatorViewModel: AnyPublisher<NavigatorViewModel, Never> {
        return $totalPages
            .map { [unowned self] totalPages in
                    .init(totalPages: totalPages,
                          isEnabledTap: self.isEnabledTap) { [weak self] index in
                        self?.getBooks(by: index)
                    }
            }.eraseToAnyPublisher()
    }
}

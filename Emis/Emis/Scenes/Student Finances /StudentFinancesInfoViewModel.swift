//
//  StudentFinancesInfoViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 29.08.23.
//

import BrandBook
import Combine
import Resolver
import SSO
import Core

final class StudentFinancesInfoViewModel {
    
    @Published private var listCells: [any CellModel] = []
    @Published private var isLoading: Bool = true
    @Injected private var SSO: SSOManager
    private var financialInfo: StudentFinancials?
    
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
    var pageIsLoading: AnyPublisher<Bool, Never> {
        $isLoading.eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        loadStudentFinancialInfo()
    }
}

extension StudentFinancesInfoViewModel {
    
    private func getSpacerCell() -> SpacerCellModel {
        .init()
    }
}

extension StudentFinancesInfoViewModel {
    
    private func loadStudentFinancialInfo() {
        financialInfo = .init(tuitionFee: 100, tuitionFeePaid: 200, scholarship: 190)
        isLoading = false
        draw()
//        @Injected var studentFinancialInfoUseCase: StudentFinancialUseCase
//
//        studentFinancialInfoUseCase.getStudentFinancialInfo(userId: SSO.userId?.description ?? "")
//            .sink { [weak self] completion in
//                guard let self else { return }
//                switch completion {
//                case .finished:
//                    self.draw()
//                    self.isLoading = false
//                case .failure(let error):
//                    self.isLoading = false
//                }
//            } receiveValue: { [weak self] model in
//                self?.financialInfo = model
//            }.store(in: &subscriptions)
    }
}

extension StudentFinancesInfoViewModel {
    
    private func draw() {
        getFinancialInfo().map { listCells = $0 }
    }
    
    func getFinancialInfo() -> [any CellModel]? {
        guard let financialInfo else { return nil }
        
        let row = RowItemCellModel(model: .init(labels: .one(model: .init(text: financialInfo.tuitionFee.description))))
        
        return [row]
    }
}

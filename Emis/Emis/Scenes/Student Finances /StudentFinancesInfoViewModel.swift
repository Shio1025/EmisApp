//
//  StudentFinancesInfoViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 29.08.23.
//

import BrandBook
import UIKit
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
    
    private func getRoundedHeaderWithTitle(title: String) -> RoundedHeaderWithTitleModel {
        .init(headerTitle: title)
    }
    
    private func getRoundedFooterModel() -> RoundedFooterModel {
        .init()
    }
}

extension StudentFinancesInfoViewModel {
    
    private func loadStudentFinancialInfo() {
        financialInfo = .init(tuitionFee: 100, scholarship: 100, effectiveFee: 100, tuitionFeePaid: 100, debt: 100)
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
        var rows: [any CellModel] = []
        rows.append(getRoundedHeaderWithTitle(title: "ფინანსური მონაცემები"))
        
        rows.append(RowItemCellModel(model:
                .init(labels: .one(model: .init(text: "საფასური")),
                      rightItem: .label(model: .init(text: financialInfo.tuitionFee.description)),
                      isSeparatorNeeded: true)))
        rows.append(RowItemCellModel(model:
                .init(labels: .one(model: .init(text: "გრანტი")),
                      rightItem: .label(model: .init(text: financialInfo.scholarship.description)),
                      isSeparatorNeeded: true)))
        rows.append(RowItemCellModel(model:
                .init(labels: .one(model: .init(text: "ეფ. გადასახადი")),
                      rightItem: .label(model: .init(text: financialInfo.effectiveFee.description)),
                      isSeparatorNeeded: true)))
        rows.append(RowItemCellModel(model:
                .init(labels: .one(model: .init(text: "გადახდილი თანხა")),
                      rightItem: .label(model: .init(text: financialInfo.tuitionFeePaid.description)),
                      isSeparatorNeeded: true)))
        let debtColor: UIColor = financialInfo.debt <= .zero
                ? BrandBookManager.Color.General.green.uiColor
                : BrandBookManager.Color.General.red.uiColor
        rows.append(RowItemCellModel(model:
                .init(labels: .one(model: .init(text: "დავალიანება")),
                      rightItem: .label(model: .init(text: financialInfo.debt.description,
                                                    color: debtColor)))))
        rows.append(getRoundedFooterModel())
        
        return rows
    }
}

//
//  GpaCalculatorViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 03.09.23.
//

import BrandBook
import Combine
import Resolver
import Core
import UIKit

final class GpaCalculatorViewModel {
    
    @Published private var listCells: [any CellModel] = []
    private var email = CurrentValueSubject<String, Never>("")
    @Published private var buttonState: ButtonState = .enabled
    @Published private var statusBanner: StatusBannerViewModel?
    
    private var gpa: Double?
    private var A: Double?
    private var B: Double?
    private var C: Double?
    private var D: Double?
    private var E: Double?
    private var F: Double?
    
    
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
    var displayBannerPublisher: AnyPublisher<StatusBannerViewModel, Never> {
         $statusBanner
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        draw()
    }
    
    private func draw() {
        var rows: [any CellModel] = [getRoundedHeaderModel(),
                                     aCellModel,
                                     SeparatorCellModel(),
                                     bCellModel,
                                     SeparatorCellModel(),
                                     cCellModel,
                                     SeparatorCellModel(),
                                     dCellModel,
                                     SeparatorCellModel(),
                                     eCellModel,
                                     SeparatorCellModel(),
                                     fCellModel,
                                     getRoundedFooterModel()]
        if let gpa {
            let gpaRow = LocalLabelCellModel(model: .init(text: Formatter.formatNumber(number: gpa),
                                                          font: .boldSystemFont(ofSize: .XL)))
            rows.insert(gpaRow, at: 1)
        }
        
        listCells = rows
    }
}

extension GpaCalculatorViewModel {
    
    private func getRoundedFooterModel() -> RoundedFooterModel {
        .init()
    }
    
    private func getRoundedHeaderModel() -> RoundedHeaderModel {
        .init()
    }
    
    private func getRoundedHeaderWithTitle(title: String) -> RoundedHeaderWithTitleModel {
        .init(headerTitle: title)
    }
    
    private func getSpacerCell() -> SpacerCellModel {
        .init()
    }
    
}

extension GpaCalculatorViewModel {
    
    var aCellModel: TextFieldCellModel {
        .init(model: .init(placeholder: "შეიყვანეთ A-ის კრედიტების ჯამური რაოდენობა",
                           keyboardType: .phonePad,
                           onEditingDidEnd: { [weak self] text in
            guard let credits = Double(text.trimmingCharacters(in: .whitespaces)) else {
                self?.statusBanner = .init(bannerType: .failure,
                                           description: "შეიყვანეთ სწორი ფორმატით")
                return
            }
            self?.A = credits
        }))
    }
    
    var bCellModel: TextFieldCellModel {
        .init(model: .init(placeholder: "შეიყვანეთ B-ის კრედიტების ჯამური რაოდენობა",
                           keyboardType: .phonePad,
                           onEditingDidEnd: { [weak self] text in
            guard let credits = Double(text.trimmingCharacters(in: .whitespaces)) else {
                self?.statusBanner = .init(bannerType: .failure,
                                           description: "შეიყვანეთ სწორი ფორმატით")
                return
            }
            self?.B = credits
        }))
    }
    
    var cCellModel: TextFieldCellModel {
        .init(model: .init(placeholder: "შეიყვანეთ C-ის კრედიტების ჯამური რაოდენობა",
                           keyboardType: .phonePad,
                           onEditingDidEnd: { [weak self] text in
            guard let credits = Double(text.trimmingCharacters(in: .whitespaces)) else {
                self?.statusBanner = .init(bannerType: .failure,
                                           description: "შეიყვანეთ სწორი ფორმატით")
                return
            }
            self?.C = credits
        }))
    }
    
    var dCellModel: TextFieldCellModel {
        .init(model: .init(placeholder: "შეიყვანეთ D-ის კრედიტების ჯამური რაოდენობა",
                           keyboardType: .phonePad,
                           onEditingDidEnd: { [weak self] text in
            guard let credits = Double(text.trimmingCharacters(in: .whitespaces)) else {
                self?.statusBanner = .init(bannerType: .failure,
                                           description: "შეიყვანეთ სწორი ფორმატით")
                return
            }
            self?.D = credits
        }))
    }
    
    var eCellModel: TextFieldCellModel {
        .init(model: .init(placeholder: "შეიყვანეთ E-ის კრედიტების ჯამური რაოდენობა",
                           keyboardType: .phonePad,
                           onEditingDidEnd: { [weak self] text in
            guard let credits = Double(text.trimmingCharacters(in: .whitespaces)) else {
                self?.statusBanner = .init(bannerType: .failure,
                                           description: "შეიყვანეთ სწორი ფორმატით")
                return
            }
            self?.E = credits
        }))
    }
    
    var fCellModel: TextFieldCellModel {
        .init(model: .init(placeholder: "შეიყვანეთ F-ის კრედიტების ჯამური რაოდენობა",
                           keyboardType: .phonePad,
                           onEditingDidEnd: { [weak self] text in
            guard let credits = Double(text.trimmingCharacters(in: .whitespaces)) else {
                self?.statusBanner = .init(bannerType: .failure,
                                           description: "შეიყვანეთ სწორი ფორმატით")
                return
            }
            self?.F = credits
        }))
    }
    
    
    var continueButtonModel: PrimaryButtonModel {
        .init(titleModel: .init(text: "გამოთვლა",
                                color: BrandBookManager.Color.General.white.uiColor,
                                font: .systemFont(ofSize: .L,
                                                  weight: .semibold)),
              state: $buttonState.eraseToAnyPublisher(),
              action: { [weak self] in
            self?.calculateGPA()
        })
    }
}

extension GpaCalculatorViewModel {
    
    private func calculateGPA() {
        let sum = [A, B, C, D, E, F].compactMap { $0 }.reduce(0, +)
        guard sum != .zero else {
            gpa = nil
            return
        }
        
        let scoringModel: [(Double?, Double)] = [(A, 4), (B, 3.38), (C, 2.77), (D, 2.16), (E, 1.55), (F, 0)]
        
        let totalScore = scoringModel.reduce(0.0) { (partialResult, pair) -> Double in
            if let value = pair.0 {
                return partialResult + (value * pair.1)
            } else {
                return partialResult
            }
        }
        
        gpa = totalScore/sum
        draw()
    }
}
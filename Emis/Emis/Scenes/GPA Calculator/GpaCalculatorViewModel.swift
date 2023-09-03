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
    private var A: Int?
    private var B: Int?
    private var C: Int?
    private var D: Int?
    private var E: Int?
    private var F: Int?
    
    
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
            
            let gpaBanner = GpaBannerCellModel(text: .init(text: Formatter.formatNumber(number: gpa),
                                                           font: .boldSystemFont(ofSize: .XL)),
                                               lottie: .init(animationName: getLottieAnimationName(with: gpa),
                                                             bundle: Bundle(identifier: "Shio.BrandBook")!))
            rows.append(SpacerCellModel())
            rows.append(gpaBanner)
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
    
    private func getSpacerCell() -> SpacerCellModel {
        .init()
    }
    
}

extension GpaCalculatorViewModel {
    
    var aCellModel: TextFieldCellModel {
        .init(model: .init(placeholder: "შეიყვანეთ A-ის კრედიტების ჯამური რაოდენობა",
                           keyboardType: .phonePad,
                           currText: A?.description ?? "",
                           onEditingDidEnd: { [weak self] text in
            guard !text.isEmpty else {
                self?.A = nil
                self?.draw()
                return
            }
            
            guard let credits = Int(text.trimmingCharacters(in: .whitespaces)) else {
                self?.A = nil
                self?.draw()
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
                           currText: B?.description ?? "",
                           onEditingDidEnd: { [weak self] text in
            guard !text.isEmpty else {
                self?.B = nil
                self?.draw()
                return
            }
            
            guard let credits = Int(text.trimmingCharacters(in: .whitespaces)) else {
                self?.B = nil
                self?.draw()
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
                           currText: C?.description ?? "",
                           onEditingDidEnd: { [weak self] text in
            guard !text.isEmpty else {
                self?.C = nil
                self?.draw()
                return
            }
            
            guard let credits = Int(text.trimmingCharacters(in: .whitespaces)) else {
                self?.C = nil
                self?.draw()
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
                           currText: D?.description ?? "",
                           onEditingDidEnd: { [weak self] text in
            guard !text.isEmpty else {
                self?.D = nil
                self?.draw()
                return
            }
            
            guard let credits = Int(text.trimmingCharacters(in: .whitespaces)) else {
                self?.D = nil
                self?.draw()
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
                           currText: E?.description ?? "",
                           onEditingDidEnd: { [weak self] text in
            guard !text.isEmpty else {
                self?.E = nil
                self?.draw()
                return
            }
            guard let credits = Int(text.trimmingCharacters(in: .whitespaces)) else {
                self?.E = nil
                self?.draw()
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
                           currText: F?.description ?? "",
                           onEditingDidEnd: { [weak self] text in
            guard !text.isEmpty else {
                self?.F = nil
                self?.draw()
                return
            }
            guard let credits = Int(text.trimmingCharacters(in: .whitespaces)) else {
                self?.F = nil
                self?.draw()
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
        
        let scoringModel: [(Int?, Double)] = [(A, 4), (B, 3.38), (C, 2.77), (D, 2.16), (E, 1.55), (F, 0)]
        
        let totalScore = scoringModel.reduce(0.0) { (partialResult, pair) -> Double in
            if let value = pair.0 {
                return partialResult + (Double(value) * pair.1)
            } else {
                return partialResult
            }
        }
        
        gpa = totalScore/Double(sum)
        draw()
    }
    
    private func getLottieAnimationName(with gpa: Double) -> String {
        if gpa > 3.38 {
            return BrandBookManager.Lottie.boss
        }
        return BrandBookManager.Lottie.normal_gpa
    }
}

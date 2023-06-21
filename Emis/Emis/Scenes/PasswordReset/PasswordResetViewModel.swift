//
//  PasswordResetViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 21.06.23.
//

import BrandBook
import Combine
import Resolver
import SSO
import Core
import UIKit

enum PasswordResetRoute {
    case successPage
}

final class PasswordResetViewModel {
    
    @Published private var router: PasswordResetRoute?
    @Published private var listCells: [any CellModel] = []
    private var email = CurrentValueSubject<String, Never>("")
    @Published private var newPassword: String = ""
    @Published private var repeatedNewPassword: String = ""
    
    private var validToContinue: AnyPublisher<ButtonState, Never> {
        return Publishers.CombineLatest3(email,$newPassword, $repeatedNewPassword)
            .map { email, newPassword, repeatedNewPassword in
                //Add some validation in Future if Needed
                if !email.isEmpty && !newPassword.isEmpty  && newPassword == repeatedNewPassword {
                    return .enabled
                } else {
                    return .disabled
                }
            }.eraseToAnyPublisher()
    }
    
    var listCellModels: AnyPublisher<[any CellModel], Never> {
        $listCells.eraseToAnyPublisher()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        listCells = [getRoundedHeaderModel(),
                     emailCellModel,
                     newPasswordCellModel,
                     repeatNewPasswordCellModel,
                     getRoundedFooterModel()]
    }
}

extension PasswordResetViewModel {
    
    func getRouter() -> AnyPublisher<PasswordResetRoute?, Never> {
        $router.eraseToAnyPublisher()
    }
}

extension PasswordResetViewModel {
    
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

extension PasswordResetViewModel {
    
    var emailCellModel: TextFieldCellModel {
        .init(model: .init(placeholder: "შეიყვანეთ ელ-ფოსტა",
                           onEditingDidEnd: { text in
            self.email.send(text)
        }))
    }
    
    var newPasswordCellModel: TextFieldCellModel {
        .init(model: .init(placeholder: "შეიყვანეთ ახალი პაროლი",
                           onEditingDidEnd: {  text in
            self.newPassword = text
        }))
    }
    
    var repeatNewPasswordCellModel: TextFieldCellModel {
        .init(model: .init(placeholder: "გაიმეორეთ პაროლი",
                           onEditingDidEnd: { text in
            self.repeatedNewPassword = text
        }))
    }
    
    var continueButtonModel: PrimaryButtonModel {
        .init(titleModel: .init(text: "შესვლა",
                                color: BrandBookManager.Color.General.white.uiColor,
                                font: .systemFont(ofSize: .L,
                                                  weight: .semibold)),
              state: validToContinue,
              action: { 
            print("success")
        })
    }
}

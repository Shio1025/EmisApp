//
//  LoginPageViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 11.05.23.
//

import BrandBook
import Combine
import Resolver

enum LoginPageRoute {
    case login
}

final class LoginPageViewModel {
    
    @Published private var router: LoginPageRoute?
    @Published private var labelText: String = "შესვლა"
    @Published private var leadingInputText: String = "რეგისტრაცია"
    @Published private var trailingInputText: String = "დაგავიწყდა მონაცემები?"
    @Published private var login: String = ""
    @Published private var password: String = ""
    @Published private var buttonText: String = "შესვლა"
    private var validToContinue: AnyPublisher<ButtonState, Never> {
        return Publishers.CombineLatest($login, $password)
            .map { login, password in
                //Add some validation in Future if Needed
                if !login.isEmpty && !password.isEmpty {
                    return .enabled
                } else {
                    return .disabled
                }
            }.eraseToAnyPublisher()
    }
    
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() { }
    
}

extension LoginPageViewModel {
    
    func getRouter() -> AnyPublisher<LoginPageRoute?, Never> {
        $router.eraseToAnyPublisher()
    }
}

extension LoginPageViewModel {
    
    var labelModel: AnyPublisher<LocalLabelModel, Never> {
        return Just (LocalLabelModel.init(text: $labelText.eraseToAnyPublisher(),
                                          color: BrandBookManager.Color.General.black.uiColor,
                                          font: .systemFont(ofSize: .L,
                                                            weight: .semibold))).eraseToAnyPublisher()
    }
    
    var emailModel: AnyPublisher<TextFieldViewModel, Never> {
        return Just (TextFieldViewModel(placeholder: "ელ-ფოსტა",
                                        onEditingDidEnd: { [weak self] text in
            self?.login = text
        })).eraseToAnyPublisher()
    }
    
    var passwordModel: AnyPublisher<TextFieldViewModel, Never> {
        return Just (TextFieldViewModel(placeholder: "პაროლი",
                                        trailingLabelModel: .init(text: $trailingInputText.eraseToAnyPublisher(),
                                                                  color: BrandBookManager.Color.Theme.Component.solid500.uiColor,
                                                                  font: .systemFont(ofSize: .M,
                                                                                    weight: .bold)),
                                        leadingLabelModel: .init(text: $leadingInputText.eraseToAnyPublisher(),
                                                                 color: BrandBookManager.Color.Theme.Component.solid500.uiColor,
                                                                 font: .systemFont(ofSize: .M,
                                                                                   weight: .bold)),
                                        onEditingDidEnd: { [weak self] text in
            self?.password = text
        })).eraseToAnyPublisher()
    }
    
    var continueButtonModel: AnyPublisher<PrimaryButtonModel, Never> {
        return Just(PrimaryButtonModel(titleModel: .init(text: $buttonText.eraseToAnyPublisher(),
                                                         color: BrandBookManager.Color.General.white.uiColor,
                                                         font: .systemFont(ofSize: .M,
                                                                           weight: .semibold)),
                                       state: validToContinue,
                                       action: { [weak self] in
            if self?.login == "petre" && self?.password == "petre" {
                self?.router = .login
            }
        })).eraseToAnyPublisher()
    }
}



//
//  LoginPageViewModel.swift
//  Emis
//
//  Created by Shio Birbichadze on 11.05.23.
//

import BrandBook
import Combine
import Resolver
import SSO

enum LoginPageRoute {
    case login
    case resetPassword
    case register
}

final class LoginPageViewModel {
    
    @Published private var router: LoginPageRoute?
    @Published private var login: String = ""
    @Published private var password: String = ""
    @Injected private var SSO: SSOManager
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
        return Just (LocalLabelModel.init(text: "შესვლა",
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
                                        trailingLabelModel: .init(text: "რეგისტრაცია",
                                                                  color: BrandBookManager.Color.Theme.Component.solid500.uiColor,
                                                                  font: .systemFont(ofSize: .M,
                                                                                    weight: .bold)),
                                        leadingLabelModel: .init(text: "დაგავიწყდა მონაცემები?",
                                                                 color: BrandBookManager.Color.Theme.Component.solid500.uiColor,
                                                                 font: .systemFont(ofSize: .M,
                                                                                   weight: .bold),
                                                                 action: {
                                   self.router = .resetPassword
                               }),
                                        isSecureEntry: true,
                                        onEditingDidEnd: { [weak self] text in
            self?.password = text
        })).eraseToAnyPublisher()
    }
    
    var continueButtonModel: AnyPublisher<PrimaryButtonModel, Never> {
        return Just(PrimaryButtonModel(titleModel: .init(text: "შესვლა",
                                                         color: BrandBookManager.Color.General.white.uiColor,
                                                         font: .systemFont(ofSize: .M,
                                                                           weight: .semibold)),
                                       state: validToContinue,
                                       action: { [weak self] in
            self?.handleLogin()
        })).eraseToAnyPublisher()
    }
    
    private func handleLogin() {
        SSO.logInUser(email: login, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("User ---- \(self?.login ?? "") -- logged in Successfuly")
                case .failure(_):
                    print("Something went wrong")
                }
            } receiveValue: { [weak self] loginSuccessfuly in
                self?.router = .login
            }.store(in: &subscriptions)
    }
}



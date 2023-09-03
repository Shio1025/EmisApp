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
import Core

enum LoginPageRoute {
    case profile
    case resetPassword
    case register
}

final class LoginPageViewModel {
    
    @Published private var router: LoginPageRoute?
    @Published private var login: String = ""
    @Published private var password: String = ""
    @Published private var isButtonLoading: Bool = false
    @Published private var statusBanner: StatusBannerViewModel?
    
    @Injected private var SSO: SSOManager
    private var validToContinue: AnyPublisher<ButtonState, Never> {
        return Publishers.CombineLatest3($login, $password,$isButtonLoading)
            .map { login, password, isLoading in
                guard !isLoading else { return .loading }
                if !login.isEmpty && !password.isEmpty {
                    return .enabled
                } else {
                    return .disabled
                }
            }.eraseToAnyPublisher()
    }
    
    var displayBannerPublisher: AnyPublisher<StatusBannerViewModel, Never> {
         $statusBanner
            .compactMap { $0 }
            .eraseToAnyPublisher()
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
                                          font: .systemFont(ofSize: .XL2,
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
                                        isSecureEntry: true,
                                        onEditingDidEnd: { [weak self] text in
            self?.password = text
        })).eraseToAnyPublisher()
    }
    
    var passwordResetLabelModel: AnyPublisher<LocalLabelModel, Never> {
        return Just (LocalLabelModel.init(text: "დაგავიწყდა პაროლი?",
                                          color: BrandBookManager.Color.Theme.Component.solid500.uiColor,
                                          font: .systemFont(ofSize: .L,
                                                            weight: .semibold),
                                          action: {
            self.router = .resetPassword
        })).eraseToAnyPublisher()
    }
    
    var RegistrationLabelModel: AnyPublisher<LocalLabelModel, Never> {
        return Just (LocalLabelModel.init(text: "ჯერ კიდევ არ ხარ დარეგისტრირებული? დარეგისტრირდი",
                                          color: BrandBookManager.Color.Theme.Component.solid500.uiColor,
                                          font: .systemFont(ofSize: .L,
                                                            weight: .semibold),
                                          action: {
            self.router = .register
        })).eraseToAnyPublisher()
    }
    
    var continueButtonModel: AnyPublisher<PrimaryButtonModel, Never> {
        return Just(PrimaryButtonModel(titleModel: .init(text: "შესვლა",
                                                         color: BrandBookManager.Color.General.white.uiColor,
                                                         font: .systemFont(ofSize: .L,
                                                                           weight: .semibold)),
                                       state: validToContinue,
                                       action: { [weak self] in
            self?.isButtonLoading = true
            self?.handleLogin()
        })).eraseToAnyPublisher()
    }
    
    private func handleLogin() {
        SSO.userLoggedInSuccessfully(userEmail: login,
                                     with: .init(userType: .student))
        router = .profile
//        @Injected var loginUseCase: LoginUseCase
//
//        loginUseCase.loginUser(email: login,
//                               password: password)
//        .sink { [weak self] completion in
//            switch completion {
//            case .failure(let error):
//                self?.statusBanner = .init(bannerType: .failure,
//                                           description: error.localizedDescription)
//            case .finished:
//                self?.router = .profile
//            }
//            self?.isButtonLoading = false
//        } receiveValue: { [weak self] model in
//            self?.SSO.userLoggedInSuccessfully(userEmail: self?.login,
//                                               with: model)
//        }.store(in: &subscriptions)
    }
}



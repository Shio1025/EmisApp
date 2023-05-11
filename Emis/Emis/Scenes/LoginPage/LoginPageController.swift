//
//  LoginPageController.swift
//  Emis
//
//  Created by Shio Birbichadze on 03.05.23.
//

import UIKit
import BrandBook
import Combine
import Resolver

class LoginPageController: UIViewController {
    
    private var viewModel: LoginPageViewModel
    @Injected private var router: LoginPageRouter
    
    private var subscriptions = Set<AnyCancellable>()
    
    
    init(viewModel: LoginPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bindRouter()
    }
}

extension LoginPageController {
    func setUp() {
        setUpUI()
        addSubviews()
        addConstraints()
    }
    
    func setUpUI() {
        view.backgroundColor = BrandBookManager.Color.Theme.Background.canvas.uiColor
    }
    
    func addSubviews() {
        
    }
    
    func addConstraints() {
        
    }
}

extension LoginPageController {
    
    private func bindRouter() {
        viewModel.getRouter()
            .compactMap { $0 }
            .sink { [weak self] route in
                guard let self = self else { return }
                self.router.route(to: route, from: self)
            }.store(in: &subscriptions)
    }
}

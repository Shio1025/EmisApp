//
//  PasswordResetController.swift
//  Emis
//
//  Created by Shio Birbichadze on 21.06.23.
//

import UIKit
import BrandBook
import Combine
import Resolver

class PasswordResetController: UIViewController {
    
    private var viewModel: PasswordResetViewModel = PasswordResetViewModel()
    @Injected private var router: PasswordResetRouter
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: GenericTableView = {
        let table = GenericTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
    }()
    
    private lazy var button: PrimaryButton = {
        let button = PrimaryButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setUp()
        bindRouter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

extension PasswordResetController {
    private func setUp() {
        setUpUI()
        addSubviews()
        addConstraints()
        registerTableCells()
        bindUI()
    }
    
    private func setUpUI() {
        view.backgroundColor = BrandBookManager.Color.Theme.Component.tr100.uiColor
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    private func addConstraints() {
        tableView.top(toView: view)
        tableView.left(toView: view)
        tableView.right(toView: view)
        tableView.relativeBottom(toView: button)
        
        button.left(toView: view)
        button.right(toView: view)
        button.bottom(toView: view)
    }
    
    private func registerTableCells() {
        tableView.register(RoundedFooter.self)
        tableView.register(RoundedHeader.self)
        tableView.register(TextFieldCell.self)
    }
}

extension PasswordResetController {
    
    private func bindRouter() {
        viewModel.getRouter()
            .compactMap { $0 }
            .sink { [weak self] route in
                guard let self else { return }
                self.router.route(to: route, from: self)
            }.store(in: &subscriptions)
    }
}


extension PasswordResetController {
    
    private func bindUI() {
        tableView.bind(with: viewModel.listCellModels)
        button.bind(with: viewModel.continueButtonModel)
    }
}


extension PasswordResetController: CustomNavigatable {
    var navTitle: NavigationTitle {
        .init(text: "პაროლის განახლება")
    }
}

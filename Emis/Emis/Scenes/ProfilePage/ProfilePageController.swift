//
//  ProfilePageController.swift
//  Emis
//
//  Created by Shio Birbichadze on 17.06.23.
//

import UIKit
import BrandBook
import Combine
import Resolver

class ProfilePageController: UIViewController {
    
    private var viewModel: ProfilePageViewModel
    @Injected private var router: ProfilePageRouter
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: GenericTableView = {
        let table = GenericTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
    }()
    
    init(viewModel: ProfilePageViewModel) {
        self.viewModel = viewModel
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
}

extension ProfilePageController {
    func setUp() {
        setUpUI()
        addSubviews()
        addConstraints()
        bindUI()
    }
    
    func setUpUI() {
        view.backgroundColor = BrandBookManager.Color.Theme.Background.canvas.uiColor
    }
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func addConstraints() {
        tableView.top(toView: view)
        tableView.left(toView: view)
        tableView.right(toView: view)
        tableView.bottom(toView: view)
    }
}

extension ProfilePageController {
    
    private func bindRouter() {
        viewModel.getRouter()
            .compactMap { $0 }
            .sink { [weak self] route in
                guard let self else { return }
                self.router.route(to: route, from: self)
            }.store(in: &subscriptions)
    }
}


extension ProfilePageController {
    
    private func bindUI() {
        
    }
}


extension ProfilePageController: CustomNavigatable {
    var navTitle: NavigationTitle {
        .init(text: "პროფილი")
    }
    
    var leftBarItems: [UIBarButtonItem]? { nil }
}

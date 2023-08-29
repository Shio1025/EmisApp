//
//  MoreMenuController.swift
//  Emis
//
//  Created by Shio Birbichadze on 03.05.23.
//

import UIKit
import BrandBook
import Combine
import Resolver

class MoreMenuController: UIViewController {
    
    private var viewModel: MoreMenuViewModel
    @Injected private var router: MoreMenuRouter
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: GenericTableView = {
        let table = GenericTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
    }()
    
    init(viewModel: MoreMenuViewModel) {
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

extension MoreMenuController {
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
    }
    
    private func addConstraints() {
        tableView.top(toView: view)
        tableView.left(toView: view, constant: .S)
        tableView.right(toView: view, constant: .S)
        tableView.bottom(toView: view)
    }
    
    private func registerTableCells() {
        tableView.register(RoundedFooter.self)
        tableView.register(RoundedHeader.self)
        tableView.register(RoundedHeaderWithTitle.self)
        tableView.register(SpacerCell.self)
        tableView.register(RowItemCell.self)
    }
}

extension MoreMenuController {
    
    private func bindRouter() {
        viewModel.getRouter()
            .compactMap { $0 }
            .sink { [weak self] route in
                guard let self else { return }
                self.router.route(to: route, from: self)
            }.store(in: &subscriptions)
    }
}


extension MoreMenuController {
    
    private func bindUI() {
        tableView.bind(with: viewModel.listCellModels)
    }
}


extension MoreMenuController: CustomNavigatable {
    var navTitle: NavigationTitle {
        .init(text: "მეტი")
    }
    
    var leftBarItems: [UIBarButtonItem]? { nil }
}

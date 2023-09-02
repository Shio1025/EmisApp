//
//  TeacherSubjectCardController.swift
//  Emis
//
//  Created by Shio Birbichadze on 02.09.23.
//

import UIKit
import BrandBook
import Combine
import Resolver

class TeacherSubjectCardController: UIViewController {
    
    private var viewModel: TeacherSubjectCardViewModel = TeacherSubjectCardViewModel()
    @Injected private var router: TeacherSubjectCardRouter
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: GenericTableView = {
        let table = GenericTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
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
}

extension TeacherSubjectCardController {
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
        tableView.topNotSafe(toView: view)
        tableView.left(toView: view, constant: .S)
        tableView.right(toView: view, constant: .S)
        tableView.bottom(toView: view)
    }
    
    private func registerTableCells() {
        tableView.register(SpacerCell.self)
        tableView.register(BannerCell.self)
        tableView.register(InlineFeedbackCell.self)
    }
}

extension TeacherSubjectCardController {
    
    private func bindRouter() {
        viewModel.getRouter()
            .compactMap { $0 }
            .sink { [weak self] route in
                guard let self else { return }
                self.router.route(to: route, from: self)
            }.store(in: &subscriptions)
    }
}


extension TeacherSubjectCardController {
    
    private func bindUI() {
        tableView.bind(with: viewModel.listCellModels)
        viewModel.pageIsLoading.sink { [weak self] isLoading in
            isLoading ? self?.showLoader() : self?.hideLoader()
        }.store(in: &subscriptions)
    }
}


extension TeacherSubjectCardController: CustomNavigatable {
    var navTitle: NavigationTitle {
        .init(text: "მთავარი")
    }
    
    var leftBarItems: [UIBarButtonItem]? { nil }
}


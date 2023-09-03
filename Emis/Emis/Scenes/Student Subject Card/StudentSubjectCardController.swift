//
//  StudentSubjectCardController.swift
//  Emis
//
//  Created by Shio Birbichadze on 01.09.23.
//

import UIKit
import BrandBook
import Combine
import Resolver

class StudentSubjectCardController: UIViewController {
    
    private var viewModel: StudentSubjectCardViewModel = StudentSubjectCardViewModel()
    @Injected private var router: StudentSubjectCardRouter
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

extension StudentSubjectCardController {
    
    private func bindRouter() {
        viewModel.getRouter()
            .compactMap { $0 }
            .sink { [weak self] route in
                guard let self else { return }
                self.router.route(to: route, from: self)
            }.store(in: &subscriptions)
    }
}

extension StudentSubjectCardController {
    
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
        tableView.bottomNotSafe(toView: view)
    }
    
    private func registerTableCells() {
        tableView.register(RowItemCell.self)
        tableView.register(RoundedHeaderWithTitle.self)
        tableView.register(RoundedFooter.self)
        tableView.register(PageDescriptionCell.self)
        tableView.register(SpacerCell.self)
    }
}

extension StudentSubjectCardController {
    
    private func bindUI() {
        tableView.bind(with: viewModel.listCellModels)
        viewModel.pageIsLoading.sink { [weak self] isLoading in
            DispatchQueue.main.async {
                isLoading ? self?.showLoader() : self?.hideLoader()
            }
        }.store(in: &subscriptions)
        viewModel.displayBannerPublisher.sink { [weak self] statusBannerModel in
            DispatchQueue.main.async {
                self?.displayBanner(with: statusBannerModel.description,
                                    state: statusBannerModel.bannerType)
            }
        }.store(in: &subscriptions)
    }
}


extension StudentSubjectCardController: CustomNavigatable {
    var navTitle: NavigationTitle {
        .init(text: "სასწავლო ბარათი")
    }
}

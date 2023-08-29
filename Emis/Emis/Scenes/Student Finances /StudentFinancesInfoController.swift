//
//  StudentFinancesInfoController.swift
//  Emis
//
//  Created by Shio Birbichadze on 29.08.23.
//

import UIKit
import BrandBook
import Combine
import Resolver

class StudentFinancesInfoController: UIViewController {
    
    private var viewModel: StudentFinancesInfoViewModel = StudentFinancesInfoViewModel()
    
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

extension StudentFinancesInfoController {
    
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
        tableView.left(toView: view)
        tableView.right(toView: view)
        tableView.bottom(toView: view)
    }
    
    private func registerTableCells() {
        tableView.register(RowItemCell.self)
        tableView.register(BannerCell.self)
        tableView.register(InlineFeedbackCell.self)
    }
}

extension StudentFinancesInfoController {
    
    private func bindUI() {
        tableView.bind(with: viewModel.listCellModels)
        viewModel.pageIsLoading.sink { [weak self] isLoading in
            isLoading ? self?.showLoader() : self?.hideLoader()
        }.store(in: &subscriptions)
    }
}


extension StudentFinancesInfoController: CustomNavigatable {
    var navTitle: NavigationTitle {
        .init(text: "ჩემი ფინანსები")
    }
}


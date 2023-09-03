//
//  GpaCalculatorController.swift
//  Emis
//
//  Created by Shio Birbichadze on 03.09.23.
//

import UIKit
import BrandBook
import Combine
import Resolver

class GpaCalculatorController: UIViewController {
    
    private var viewModel: GpaCalculatorViewModel = GpaCalculatorViewModel()
    
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

extension GpaCalculatorController {
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
        tableView.left(toView: view, constant: .S)
        tableView.right(toView: view, constant: .S)
        tableView.relativeBottom(toView: button)
        
        button.left(toView: view)
        button.right(toView: view)
        button.bottom(toView: view)
    }
    
    private func registerTableCells() {
        tableView.register(RoundedFooter.self)
        tableView.register(RoundedHeader.self)
        tableView.register(TextFieldCell.self)
        tableView.register(SeparatorCell.self)
        tableView.register(LocalLabelCell.self)
        tableView.register(GpaBannerCell.self)
        tableView.register(SpacerCell.self)
    }
}


extension GpaCalculatorController {
    
    private func bindUI() {
        tableView.bind(with: viewModel.listCellModels)
        button.bind(with: viewModel.continueButtonModel)
        viewModel.displayBannerPublisher.sink { [weak self] statusBannerModel in
            DispatchQueue.main.async {
                self?.displayBanner(with: statusBannerModel.description,
                                    state: statusBannerModel.bannerType)
            }
        }.store(in: &subscriptions)
    }
}


extension GpaCalculatorController: CustomNavigatable {
    var navTitle: NavigationTitle {
        .init(text: "GPA კალკულატორი")
    }
}


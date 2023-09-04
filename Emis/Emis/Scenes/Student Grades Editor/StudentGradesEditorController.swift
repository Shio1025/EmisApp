//
//  StudentGradesEditorController.swift
//  Emis
//
//  Created by Shio Birbichadze on 02.09.23.
//

import UIKit
import BrandBook
import Combine
import Resolver

class StudentGradesEditorController: UIViewController {
    
    private var viewModel: StudentGradesEditorViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: GenericTableView = {
        let table = GenericTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
    }()
    
    init(viewModel: StudentGradesEditorViewModel) {
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

extension StudentGradesEditorController {
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
        tableView.register(RowItemCell.self)
        tableView.register(SecondaryButtonsCell.self)
        tableView.register(RoundedHeader.self)
        tableView.register(RoundedFooter.self)
        tableView.register(TextFieldCell.self)
        tableView.register(SeparatorCell.self)
        tableView.register(SpacerCell.self)
    }
}

extension StudentGradesEditorController {
    
    private func bindUI() {
        tableView.bind(with: viewModel.listCellModels)
        viewModel.pageIsLoading.sink { [weak self] isLoading in
            isLoading ? self?.showLoader() : self?.hideLoader()
        }.store(in: &subscriptions)
        viewModel.displayBannerPublisher.sink { [weak self] statusBannerModel in
            DispatchQueue.main.async {
                self?.displayBanner(with: statusBannerModel.description,
                                    state: statusBannerModel.bannerType)
            }
        }.store(in: &subscriptions)
    }
}


extension StudentGradesEditorController: CustomNavigatable {
    
    var navTitle: NavigationTitle {
        .init(text: viewModel.studentNameAndSurname)
    }
}

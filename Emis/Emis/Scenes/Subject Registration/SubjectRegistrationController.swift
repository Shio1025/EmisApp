//
//  SubjectRegistrationController.swift
//  Emis
//
//  Created by Shio Birbichadze on 03.09.23.
//

import UIKit
import BrandBook
import Combine
import Resolver
import Lottie

class SubjectRegistrationController: UIViewController {
    
    private var viewModel: SubjectRegistrationViewModel = SubjectRegistrationViewModel()
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var subjectNameTextField: TextFieldView = {
        let textField = TextFieldView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.height(equalTo: 40)
        return textField
    }()
    
    private lazy var label: LocalLabel = {
        let label = LocalLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var topStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = .M
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = BrandBookManager.Color.Theme.Background.layer.uiColor
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = .init(top: .S,
                                               leading: .M,
                                               bottom: .S,
                                               trailing: .M)
        return stack
    }()
    
    private lazy var tableView: GenericTableView = {
        let table = GenericTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = BrandBookManager.Color.Theme.Background.layer.uiColor
        return table
    }()
    
    private lazy var animationView: AnimationView = {
        let animation = AnimationView()
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.backgroundBehavior = .pauseAndRestore
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.animation = .named(BrandBookManager.Lottie.loader,
                                     bundle: Bundle(identifier: "Shio.BrandBook")!)
        animation.width(equalTo: 150)
        animation.height(equalTo: 150)
        return animation
    }()
    
    private lazy var navigationView: Navigator = {
        let view = Navigator()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var animationContainerView: UIView = UIView()
    
    private lazy var animationAndTableContainer: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [tableView,
                                                   animationContainerView])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = BrandBookManager.Color.Theme.Background.layer.uiColor
        return stack
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        animationAndTableContainer.roundCorners(by: .M)
        topStackView.roundCorners(by: .M)
    }
}

extension SubjectRegistrationController {
    
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
        view.addSubview(topStackView)
        topStackView.addArrangedSubview(subjectNameTextField)
        topStackView.addArrangedSubview(label)
        
        animationContainerView.addSubview(animationView)
        
        view.addSubview(animationAndTableContainer)
        view.addSubview(navigationView)
        view.addSubview(button)
    }
    
    private func addConstraints() {
        topStackView.top(toView: view, constant: .M)
        topStackView.left(toView: view, constant: .XS)
        topStackView.right(toView: view, constant: .XS)
        topStackView.relativeBottom(toView: animationAndTableContainer, constant: .M)
        
        animationAndTableContainer.left(toView: view, constant: .S)
        animationAndTableContainer.right(toView: view, constant: .S)
        animationAndTableContainer.relativeBottom(toView: navigationView, constant: .L)
        
        animationView.centerVertically(to: animationContainerView)
        animationView.centerHorizontally(to: animationContainerView)
        
        navigationView.left(toView: view, constant: .S)
        navigationView.right(toView: view, constant: .S)
        navigationView.relativeBottom(toView: button, constant: .L)
        
        button.left(toView: view)
        button.right(toView: view)
        button.bottom(toView: view)
    }
    
    private func registerTableCells() {
        tableView.register(InfoCell.self)
        tableView.register(RoundedHeader.self)
        tableView.register(RoundedFooter.self)
        tableView.register(SeparatorCell.self)
        tableView.register(LocalLabelCell.self)
    }
}

extension SubjectRegistrationController {
    
    private func bindUI() {
        tableView.bind(with: viewModel.listCellModels)
        subjectNameTextField.bind(model: viewModel.subjectNameTextFieldModel)
        button.bind(with: viewModel.continueButtonModel)
        viewModel.resultLabelModel.sink { [weak self] model in
            DispatchQueue.main.async {
                self?.label.bind(with: model)
            }
        }.store(in: &subscriptions)
        
        viewModel.tableIsLoading.sink { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.animationContainerView.isHidden = !isLoading
                self?.tableView.isHidden = isLoading
            }
            if isLoading { self?.animationView.play() }
        }.store(in: &subscriptions)
        
        viewModel.navigatorViewModel.sink { [weak self] navigatorViewModel in
            DispatchQueue.main.async {
                self?.navigationView.bind(model: navigatorViewModel)
            }
        }.store(in: &subscriptions)
        
        viewModel.displayBannerPublisher.sink { [weak self] statusBannerModel in
            DispatchQueue.main.async {
                self?.displayBanner(with: statusBannerModel.description,
                                    state: statusBannerModel.bannerType)
            }
        }.store(in: &subscriptions)
        viewModel.$pageIsLoading.sink { [weak self] isLoading in
            DispatchQueue.main.async {
                isLoading ? self?.showLoader() : self?.hideLoader()
            }
        }.store(in: &subscriptions)
    }
}


extension SubjectRegistrationController: CustomNavigatable {
    var navTitle: NavigationTitle {
        .init(text: "რეგისტრაცია")
    }
}


//
//  LibraryPageController.swift
//  Emis
//
//  Created by Shio Birbichadze on 30.08.23.
//

import UIKit
import BrandBook
import Combine
import Resolver
import Lottie

class LibraryPageController: UIViewController {
    
    private var viewModel: LibraryPageViewModel = LibraryPageViewModel()
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var bookNameTextField: TextFieldView = {
        let textField = TextFieldView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.height(equalTo: 40)
        return textField
    }()
    
    private lazy var bookAuthorTextField: TextFieldView = {
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

extension LibraryPageController {
    
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
        topStackView.addArrangedSubview(bookNameTextField)
        topStackView.addArrangedSubview(bookAuthorTextField)
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
    }
}

extension LibraryPageController {
    
    private func bindUI() {
        tableView.bind(with: viewModel.listCellModels)
        bookNameTextField.bind(model: viewModel.bookNameTextFieldModel)
        bookAuthorTextField.bind(model: viewModel.authorTextFieldModel)
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
        
        viewModel.pdfURL.sink { [weak self] url in
            guard let self else { return }
            DispatchQueue.main.async {
//                let documentInteractionController = UIDocumentInteractionController(url: url)
//                documentInteractionController.delegate = self
//                documentInteractionController.presentOptionsMenu(from: self.view.bounds, in: self.view, animated: true)
                let alertController = UIAlertController(title: "Download PDF", message: "Do you want to download the PDF?", preferredStyle: .alert)

                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

                alertController.addAction(UIAlertAction(title: "Download", style: .default) { _ in
//                    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//                    let destinationURL = documentsDirectory.appendingPathComponent("downloaded.pdf")
//                    do {
//                        try FileManager.default.moveItem(at: url, to: destinationURL)
//                        print("Downloaded PDF saved at: \(destinationURL)")
//                    } catch {
//                        print("Failed to save downloaded PDF: \(error.localizedDescription)")
                    //                    }
                    let documentInteractionController = UIDocumentInteractionController(url: url)
                    documentInteractionController.delegate = self
                    documentInteractionController.presentOptionsMenu(from: self.view.bounds, in: self.view, animated: true)
//                    self.savePdf(url: url, fileName: "petre")
                })
                
                self.present(alertController, animated: true, completion: nil)

            }
        }.store(in: &subscriptions)
    }
    
    func savePdf(url: URL, fileName:String) {
        DispatchQueue.main.async {
            let pdfData = try? Data.init(contentsOf: url)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "EmisApp-\(fileName).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!")
                //file is downloaded in app data container, I can find file from x code > devices > MyApp > download Container >This container has the file
            } catch {
                print("Pdf could not be saved")
            }
        }
    }
}

extension LibraryPageController: UIDocumentInteractionControllerDelegate {
    
    func documentInteractionControllerDidDismissOpenInMenu(_ controller: UIDocumentInteractionController) {
        // Update the isLoading property to false when the Open In menu is dismissed.
//        isLoading = false
    }
}


extension LibraryPageController: CustomNavigatable {
    var navTitle: NavigationTitle {
        .init(text: "ბიბლიოთეკა")
    }
}

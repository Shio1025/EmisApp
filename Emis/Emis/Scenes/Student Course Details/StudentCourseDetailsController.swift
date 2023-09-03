//
//  StudentCourseDetailsController.swift
//  Emis
//
//  Created by Shio Birbichadze on 03.09.23.
//

import UIKit
import BrandBook
import Combine
import Resolver

class StudentCourseDetailsController: UIViewController {
    
    private var viewModel: StudentCourseDetailsViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: GenericTableView = {
        let table = GenericTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
    }()
    
    init(viewModel: StudentCourseDetailsViewModel) {
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

extension StudentCourseDetailsController {
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
        tableView.register(RowItemCell.self)
        tableView.register(RoundedFooter.self)
        tableView.register(RoundedHeader.self)
        tableView.register(PrimaryButtonCell.self)
        tableView.register(RoundedHeaderWithTitle.self)
        tableView.register(LocalLabelCell.self)
    }
}

extension StudentCourseDetailsController {
    
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
        
        viewModel.pdfURL.sink { [weak self] data in
            guard let self else { return }
            DispatchQueue.main.async {
                self.present(self.createDownloadPDFAlertController(url: data.0,
                                                                   fileName: data.1),
                             animated: true,
                             completion: nil)
            }
        }.store(in: &subscriptions)
    }
    
    private func createDownloadPDFAlertController(url: URL,
                                                  fileName: String) -> UIAlertController {
        let alertController = UIAlertController(title: "Download PDF",
                                                message: "Do you want to download the PDF?", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))

        alertController.addAction(UIAlertAction(title: "Download", style: .default) { [weak self] _ in
            guard let self else { return }
            self.showLoader()
                DispatchQueue.global().async {
                    if  let data = try? Data(contentsOf: url) {
                        self.sharePdf(data,
                                      fileName: fileName)
                    } else {
                        DispatchQueue.main.async {
                            self.hideLoader()
                            self.displayBanner(with: "წიგნის გადმოწერა ვერ მოხერხდა",
                                               state: .failure)
                        }
                    }
                }
        })
        
        return alertController
    }
    
    private func sharePdf(_ data: Data,
                          fileName: String) {
        DispatchQueue.main.async {
            self.hideLoader()
            let sharer = self.sharer(data: data,
                                     name: fileName)
            self.present(sharer, animated: true)
        }
    }
    
    func sharer(data: Data,
                name: String) -> UIActivityViewController {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectorPath: String = paths[0]

        var fileName = "/EmisApp-"
        fileName += name
        fileName += ".pdf"
        
        let path = documentDirectorPath.appending(fileName)

        FileManager.default.createFile(atPath: path, contents: data, attributes: nil)

        let activity = UIActivityViewController(activityItems: [URL(fileURLWithPath: path)], applicationActivities: nil)
        activity.completionWithItemsHandler = { (activityType, completed: Bool, returnedItems: [Any]?, error: Error?) in
          
        }
        
        return activity
    }
}


extension StudentCourseDetailsController: CustomNavigatable {
    var navTitle: NavigationTitle {
        .init(text: viewModel.name)
    }
}


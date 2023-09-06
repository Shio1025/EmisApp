//
//  Navigator.swift
//  BrandBook
//
//  Created by Shio Birbichadze on 31.08.23.
//

import UIKit
import Combine

public class Navigator: UIView {
    
    @Published private var currPage: Int = 1
    @Published private var totalPages: Int?
    
    private var subscriptions = Set<AnyCancellable>()
    
    private var textPublisher: AnyPublisher<LocalLabelModel, Never> {
        return Publishers.CombineLatest($currPage, $totalPages)
            .drop(while: { _, total in
                total == nil
            })
            .map { currPage, totalPage in
                return LocalLabelModel.init(text: "\(currPage) - \(totalPage ?? 0)",
                                            color: BrandBookManager.Color.Theme.Invert.tr300.uiColor,
                                            font: .systemFont(ofSize: .L,
                                                              weight: .semibold))
            }.eraseToAnyPublisher()
    }
    
    private lazy var resourceView: ResourceView = {
        let view = ResourceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.height(equalTo: .XL6 + .XL6 + .L)
        view.width(equalTo: .XL6 + .XL5)
        return view
    }()
    
    private lazy var infoLabel: LocalLabel = {
        let label = LocalLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.setAlignment(with: .left)
        return label
    }()
    
    private lazy var leftchevronItem: SmallButton = {
        let view = SmallButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var rightchevronItem: SmallButton = {
        let view = SmallButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var leftchevronItemContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.height(equalTo: .XL3)
        view.width(equalTo: .XL3)
        return view
    }()
    
    private lazy var rightchevronItemContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.height(equalTo: .XL3)
        view.width(equalTo: .XL3)
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public init() {
        super.init(frame: .zero)
        addSubviews()
        setUpUI()
        addConstraints()
    }
    
    public convenience init(model: NavigatorViewModel) {
        self.init()
        bind(model: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func  addSubviews() {
        addSubview(containerView)
        containerView.addSubview(leftchevronItemContainer)
        containerView.addSubview(infoLabel)
        containerView.addSubview(rightchevronItemContainer)
        
        leftchevronItemContainer.addSubview(leftchevronItem)
        rightchevronItemContainer.addSubview(rightchevronItem)
    }
    
    private func setUpUI() {
        backgroundColor = BrandBookManager.Color.Theme.Background.layer.uiColor
    }
    
    private func addConstraints() {
        height(equalTo: .XL6)
        
        containerView.top(toView: self)
        containerView.bottom(toView: self)
        containerView.left(toView: self)
        containerView.right(toView: self)
        
        infoLabel.centerVertically(to: containerView)
        infoLabel.centerHorizontally(to: containerView)
        
        leftchevronItemContainer.left(toView: containerView, constant: .M)
        leftchevronItemContainer.centerVertically(to: containerView)
        
        leftchevronItem.top(toView: leftchevronItemContainer, constant: .S)
        leftchevronItem.bottom(toView: leftchevronItemContainer, constant: .S)
        leftchevronItem.left(toView: leftchevronItemContainer, constant: .S)
        leftchevronItem.right(toView: leftchevronItemContainer, constant: .S)
        
        rightchevronItemContainer.right(toView: containerView, constant: .M)
        rightchevronItemContainer.centerVertically(to: containerView)
        
        rightchevronItem.top(toView: rightchevronItemContainer, constant: .S)
        rightchevronItem.bottom(toView: rightchevronItemContainer, constant: .S)
        rightchevronItem.left(toView: rightchevronItemContainer, constant: .S)
        rightchevronItem.right(toView: rightchevronItemContainer, constant: .S)

    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        roundCorners(by: .M)
        
        leftchevronItemContainer.roundCorners(by: leftchevronItemContainer.bounds.height/2,
                                              borderColor: BrandBookManager.Color.Theme.Invert.tr100.uiColor,
                                              borderWidth: 1)
        rightchevronItemContainer.roundCorners(by: rightchevronItemContainer.bounds.height/2,
                                              borderColor: BrandBookManager.Color.Theme.Invert.tr100.uiColor,
                                              borderWidth: 1)
        
    }
}

extension Navigator {
    
    public func bind(model: NavigatorViewModel) {
        currPage = 1
        totalPages = model.totalPages == .zero ? 1 : model.totalPages
        
        textPublisher.sink { [weak self] model in
            self?.infoLabel.bind(with: model)
        }.store(in: &subscriptions)
        
        leftchevronItem.bind(model: .init(resourceType: .icon(icon: UIImage(systemName: "chevron.left")!,
                                                              tintColor: BrandBookManager.Color.Theme.Invert.tr500.uiColor.withAlphaComponent(0.8)),
                                          action: { [weak self] in
            guard let self,
                  self.currPage != 1 else { return }
            self.currPage -= 1
            model.ItemTapAction(self.currPage)
        }))
        
        rightchevronItem.bind(model: .init(resourceType: .icon(icon: UIImage(systemName: "chevron.right")!,
                                                               tintColor: BrandBookManager.Color.Theme.Invert.tr500.uiColor.withAlphaComponent(0.8)),
                                           action: { [weak self] in
            guard let self,
                  self.currPage != self.totalPages else { return }
            self.currPage += 1
            model.ItemTapAction(self.currPage)
        }))
        
        model.isEnabledTap.sink { [weak self] isEnabled in
            guard let self else { return }
            DispatchQueue.main.async {
                self.leftchevronItem.isUserInteractionEnabled = isEnabled
                self.rightchevronItem.isUserInteractionEnabled = isEnabled
                self.leftchevronItemContainer.alpha = isEnabled ? 1 : 0.5
                self.rightchevronItemContainer.alpha = isEnabled ? 1 : 0.5
            }
        }.store(in: &subscriptions)
        
        $currPage.sink { [weak self] index in
            self?.leftchevronItemContainer.isHidden = self?.totalPages != nil ? index == 1 : false
            self?.rightchevronItemContainer.isHidden = index == self?.totalPages
        }.store(in: &subscriptions)
    }
    
    public func resetSubscriptions() {
        subscriptions = Set<AnyCancellable>()
    }
}

public class NavigatorViewModel {
    
    var totalPages: Int?
    var isEnabledTap: AnyPublisher<Bool, Never>
    var ItemTapAction: (Int) -> Void
    
    public init(totalPages: Int?,
                isEnabledTap: AnyPublisher<Bool, Never>,
                ItemTapAction: @escaping (Int) -> Void) {
        self.totalPages = totalPages
        self.isEnabledTap = isEnabledTap
        self.ItemTapAction = ItemTapAction
    }
}
